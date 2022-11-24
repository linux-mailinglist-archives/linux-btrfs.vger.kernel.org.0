Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E35637EF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Nov 2022 19:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKXSdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Nov 2022 13:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKXSdH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Nov 2022 13:33:07 -0500
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FC6DFC3
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 10:33:06 -0800 (PST)
Date:   Thu, 24 Nov 2022 19:33:03 +0100
From:   Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Endless "reclaiming chunk"/"relocating block group"
Message-ID: <1669313605@msgid.manchmal.in-ulm.de>
References: <1666204197@msgid.manchmal.in-ulm.de>
 <Y1Crh/Cz2rcbIayw@hungrycats.org>
 <1666262200@msgid.manchmal.in-ulm.de>
 <Y1FSxogPeNIUfyVn@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MoQRqZm2J3CyUOuy"
Content-Disposition: inline
In-Reply-To: <Y1FSxogPeNIUfyVn@hungrycats.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--MoQRqZm2J3CyUOuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Zygo Blaxell wrote...

> TL;DR not enough people are testing new kernel code against old compilers.
> If it's problematic to keep the host system's gcc up to date, a build
> chroot for kernel building with an up to date toolchain is the way to go.

Indeed, but unfortunately this is not an option in the given environment.


Eventually I started bisecting and found the commit below introduced
the trouble. And just to make it clear, the change is correct as far as
I can see. The code built by gcc 5.4 is not.


commit ac2f1e63c65c695b6134f40a078cf82df627e188
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Tue Mar 29 01:56:07 2022 -0700

    btrfs: allow block group background reclaim for non-zoned filesystems


These final three hunks caught my attention:


@@ -3220,6 +3245,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
        spin_unlock(&info->delalloc_root_lock);

        while (total) {
+               bool reclaim;
+
                cache = btrfs_lookup_block_group(info, bytenr);
                if (!cache) {
                        ret = -ENOENT;
@@ -3265,6 +3292,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
                                        cache->space_info, num_bytes);
                        cache->space_info->bytes_used -= num_bytes;
                        cache->space_info->disk_used -= num_bytes * factor;
+
+                       reclaim = should_reclaim_block_group(cache, num_bytes);
                        spin_unlock(&cache->lock);
                        spin_unlock(&cache->space_info->lock);

@@ -3291,6 +3320,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
                if (!alloc && old_val == 0) {
                        if (!btrfs_test_opt(info, DISCARD_ASYNC))
                                btrfs_mark_bg_unused(cache);
+               } else if (!alloc && reclaim) {
+                       btrfs_mark_bg_to_reclaim(cache);
                }

                btrfs_put_block_group(cache);


It seems strange "reclaim" is not initialized but after a closer look
this turns out to be okay. That variable is initialized if "alloc" is
false (not visible in the diff above), but only used under that
condition as well (last hunk). Which is why gcc does not emit warnings
about this.

*However*, some additional debug-print statements revealed the generated
code enters the block that calls btrfs_mark_bg_to_reclaim /even/ /if/
alloc is false, and reclaim undefined (usually true).

That is fairy scary, and I have no idea how many other places in the
kernel are affected by this. I'd assume, quite a few.

Workaround is trivial by initializing reclaim to false. But still.

    Christoph

--MoQRqZm2J3CyUOuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEWXMI+726A12MfJXdxCxY61kUkv0FAmN/uNsACgkQxCxY61kU
kv1ivBAAnaFAfPfK400kT/O3YKMzvFpcuRmJF0CUHcE4mhdHdB2PulnuBBXXDS7E
Fjx2bBACaNnZMFVaGLN0m1BjATUBqAWjev85OKeIz/Akgi6MeRpWwP0ZUr0AfhF6
30kh9B+ml1xMpK/TBBxt+8deC8rnAvo0ljAz0hBslGNlqYrQx/aGAX4aoCaqWnAi
mYlpEsCbZ5HFWbjBznrcga79GECpZY3MDFwsSzbBljsNYFRzcqYC417WKE5ZknXk
/YaqL9Ypf9n92xjziRDQFSxmLJJfbE81ORTpiF1yr8zSsl6aKqDtGCu+dQ5e7drB
XsCAeZ/R3vQP7Maol09PEm3iDZFeejiko2dGbeE+OV5JnptEsqu6O+CXj4FOk8UQ
odP09xeli7V/2GIHBoqYx6M71osuU4UpSfS4LDqCt66WdreomQN8W4Z3ysLHPa2U
nIAtOqTJNPTT4jplC5dtFuyNPSg5RnhxNIMyH/Si/AIblfIiECU9hyWeYy4/9S5M
NkLLRIFDgT3UFFtW+lwoj+qm2bzTl/7WBkId5ejNhrXQ92LFH48fXKSOmtEUJ10h
xMmE9HtR3LvuUT4IzZNSPS4NouTGymjDApS948Uk7gUU3iEYBx92p6JyHRV/9dzN
f1WCKZqqnGaI9wqB9fLdFqhyKqE01Ne65+v1jQ5dXLJdOhLvpAg=
=GspD
-----END PGP SIGNATURE-----

--MoQRqZm2J3CyUOuy--
