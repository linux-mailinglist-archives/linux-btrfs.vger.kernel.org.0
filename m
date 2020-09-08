Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF402619C7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 20:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbgIHSTV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 14:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731350AbgIHSSa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Sep 2020 14:18:30 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569F6C061573
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 11:18:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v54so12682617qtj.7
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Sep 2020 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XGwrso0QyvEGqIwAODHOFwe9Wz9n+PvLrD47j45fgGQ=;
        b=MW88sCwy0wUxz+VYAcAgf9S599k30vpG4yqkz+mR96sjgH7b97IMSWhs0meM05ONrC
         BxyqIYNqdHTPld5N3hp/TWx9CwI/bs7EoUTA82W5kfvmiZHlUIE7KhbAG3ylshUqLJs6
         sPoxbm8TeZCv8BpbO0y7YeV8rgQtp5RdGN68s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGwrso0QyvEGqIwAODHOFwe9Wz9n+PvLrD47j45fgGQ=;
        b=l66ngtKpZco4S8ujX4lxjiD6w+UjLxtJhZ+/MtnI43ILhjMS8vi0wEg92JCaWHUuzv
         W8HaiCuze68xXJqYZrpaQixfz2T/r8edIuYbt8nXITzYY2UoSsgJgqe0ejJSERTMh/CM
         /AiDSQTnLBVztoHfXeO6ksl5VsJ9UStjVdFcqUXU62xtdlgzhU7t+wDpSJry0jzpN9Nk
         VbmSKzqO9XuGcOnA9ENHLGoIMMHZRKg2jKzscvZ42HNrvYAWfcW14TDXc7JyVU2zxO9h
         0eXAeQiikZkI/J4d1yL4V7k8Ql/aJrLyS3yj6qbMY1woOBLuyTYyEGKU1EFHvqFapb9d
         V+Uw==
X-Gm-Message-State: AOAM530RMWnQt7junkBCrtteHlwn7FYY7nQogJ+Ek9f27OY7O5WBshQS
        RJ4WDRERp7NeR0fLydQb5hZ96w==
X-Google-Smtp-Source: ABdhPJzHGdxqDhfwvx1NU+eWmpQn4YW0eR2K3MRNQEcYbsDQupRqrsIT/cgJQlZbk0jxqZCc0dsztA==
X-Received: by 2002:aed:20cb:: with SMTP id 69mr1431053qtb.106.1599589100498;
        Tue, 08 Sep 2020 11:18:20 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-8ebe-d43f-8015-7222-c895.inf6.spectrum.com. [2606:a000:1401:8ebe:d43f:8015:7222:c895])
        by smtp.gmail.com with ESMTPSA id q142sm23256qke.48.2020.09.08.11.18.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Sep 2020 11:18:19 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:18:17 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     u-boot@lists.denx.de,
        Alberto =?iso-8859-1?Q?S=E1nchez?= Molero 
        <alsamolero@gmail.com>, Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH U-BOOT v3 00/30] PLEASE TEST fs: btrfs: Re-implement
 btrfs support using code from btrfs-progs
Message-ID: <20200908181817.GN7259@bill-the-cat>
References: <20200624160316.5001-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MMMIZFJzhAsRj/+"
Content-Disposition: inline
In-Reply-To: <20200624160316.5001-1-marek.behun@nic.cz>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--3MMMIZFJzhAsRj/+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 06:02:46PM +0200, Marek Beh=FAn wrote:

> Hello,
>=20
> this is a cleaned up version of Qu's patches that reimplements U-Boot's
> btrfs driver with code from btrfs-progs.
>=20
> I have tested this series, found and corrected one bug (failure when
> accesing files via symlinks), and it looks it is working now, but I
> would like more people to do some testing.
>=20
> There are a lot of checkpatch warnings and errors left, I shall fix
> this in the future.
>=20
> Marek
>=20
> Changes since v2:
> - fixed btrfs_lookup_path() in patch 19 to correctly handle symlinks
> - commit messages were updated some
>   - for example they used the word "crossport" in 3 formats:
>     "crossport", "cross-port" and "cross port", this was changed
>     to "crossport"
>   - corrected some typos
>   - some English sentences were a bit weirdly written
> - fixed 2 compiler warnings (one use of maybe uninitialized variable and
>   one printf specifier warning)
> - indentation in some places was wrong (usage of 8 spaces instead of a
>   tab, for example)
> - added my Reviewed-by
> - the last patch, adding btrfs mailing list to MAINTAINRES, also adds
>   Qu as designated reviewer, so that people add him to Cc when they send
>   patches
>=20
> Changes since v1:
> - Implement btrfs_list_subvols()
>   In v1 it's completely removed thus would cause problem if btrfsolume
>   command is compiled in.
> - Rebased to latest master
>   Only minor conflicts due to header changes.
> - Allow next_legnth() to return value > BTRFS_NAME_LEN
>=20
> Below is Qu's explanation, from cover letter of v2:
>=20
> The current btrfs code in U-boot is using a creative way to read on-disk
> data.
> It's pretty simple, involving the least amount of code, but pretty
> different from btrfs-progs nor kernel, making it pretty hard to sync
> code between different projects.
>=20
> This big patchset will rework the btrfs support, to use code mostly from
> btrfs-progs, thus all existing btrfs developers will feel at home.
>=20
> During the rework, the following new features are added:
> - More hash algorithm support
>   SHA256 and XXHASH support are added.
>   BLAKE2 needs more backport, will happen in a separate patchset.
>=20
> - The ability to read degraded RAID1
>   Although we still only support one device btrfs, the new code base
>   can choose from different copies already.
>   As long as new device scan interface is provided, multi-device support
>   is pretty simple.
>=20
> - More correct handling of compressed extents with offset
>   For compressed extent with offset, we should read the whole compressed
>   extent, decompress them, then copy the referred part.
>=20
> There are some more features incoming, with the new code base it would
> be much easier to implement:
> - Data checksum support
>   The check would happen in read_extent_data(), btrfs-progs has the
>   needed facility to locate data csum.
>=20
> - BLAKE2 support
>   Need BLAKE2 library cross ported.
>   For btrfs it's just several lines of modification.
>=20
> - Multi-device support along wit degraded RAID support
>   We only need an interface to scan one device without opening it.
>   The infrastructure is already provided in this patchset.
>=20
> These new features would be submitted after the patchset get merged,
> since the patchset is already large, I don't want to make it more scary.
>=20
> Although this patchset look horribly large, most of them are code copy
> from btrfs-progs.
> E.g extent-cache.[ch], rbtree-utils.[ch], btrfs_btree.h.
> And ctree.h has over 1000 lines copied just for various accessors.
>=20
> While for disk-io.[ch] and volumes-io.[ch], they have some small
> modifications to adapt the interface of U-boot.
> E.g. btrfs_device::fd is replace with blkdev_desc and disk_partition_t.
>=20
> The new code for U-boot are related to the following functions:
> - btrfs_readlink()
> - btrfs_lookup_path()
> - btrfs_read_extent_inline()
> - btrfs_read_extent_reg()
> - lookup_data_extent()
> - btrfs_file_read()
> - btrfs_list_subvols()
>=20
> Qu Wenruo (30):
>   fs: btrfs: Sync btrfs_btree.h from kernel
>   fs: btrfs: Add more checksum algorithms
>   fs: btrfs: Crossport btrfs_read_dev_super() from btrfs-progs
>   fs: btrfs: Crossport rbtree-utils from btrfs-progs
>   fs: btrfs: Crossport extent-cache.[ch] from btrfs-progs
>   fs: btrfs: Crossport extent-io.[ch] from btrfs-progs
>   fs: btrfs: Crossport structure accessor into ctree.h
>   fs: btrfs: Crossport volumes.[ch] from btrfs-progs
>   fs: btrfs: Crossport read_tree_block() from btrfs-progs
>   fs: btrfs: Rename struct btrfs_path to struct __btrfs_path
>   fs: btrfs: Rename btrfs_root to __btrfs_root
>   fs: btrfs: Crossport struct btrfs_root to ctree.h
>   fs: btrfs: Crossport btrfs_search_slot() from btrfs-progs
>   fs: btrfs: Crossport btrfs_read_sys_array() and
>     btrfs_read_chunk_tree()
>   fs: btrfs: Crossport open_ctree_fs_info() from btrfs-progs
>   fs: btrfs: Rename path resolve related functions to avoid name
>     conflicts
>   fs: btrfs: Use btrfs_readlink() to implement __btrfs_readlink()
>   fs: btrfs: inode: Allow next_length() to return value > BTRFS_NAME_LEN
>   fs: btrfs: Implement btrfs_lookup_path()
>   fs: btrfs: Use btrfs_iter_dir() to replace btrfs_readdir()
>   fs: btrfs: Use btrfs_lookup_path() to implement btrfs_exists() and
>     btrfs_size()
>   fs: btrfs: Rename btrfs_file_read() and its callees to avoid name
>     conflicts
>   fs: btrfs: Introduce btrfs_read_extent_inline() and
>     btrfs_read_extent_reg()
>   fs: btrfs: Introduce lookup_data_extent() for later use
>   fs: btrfs: Implement btrfs_file_read()
>   fs: btrfs: Introduce function to resolve path in one subvolume
>   fs: btrfs: Introduce function to resolve the path of one subvolume
>   fs: btrfs: Imeplement btrfs_list_subvols() using new infrastructure
>   fs: btrfs: Cleanup the old implementation
>   MAINTAINERS: Add btrfs mailing list and myself as reviewer

With the changes I followed up on to specific patches, the series has
been applied to u-boot/next, thanks!

--=20
Tom

--3MMMIZFJzhAsRj/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl9XyugACgkQFHw5/5Y0
tyy7yAv+J3rN5wsjSlE2I5MJ2idB6OQUIv5IddeXogT3GLbEDxCoM7cy/aam6y8A
3DReUyN4MMIG3BMICzVvgTdCgMgcRZBV2H5k9+YFMyypBhn47gJCA8K68tItBECh
VpSnTn3nvMTRKXyVo2C+Z/hreOvHAsR3GFCcpvHwM5+RzOX5UY7bL90omPV5hnXW
M3J7gSbO7BfWDmbHfayJel0VHwldd1EuOKDvrVhk4XGF7KXkhqh8a4IQqg/bRVV6
CLj4FGhPz8ffciDpW22BeO8Qqt89gVNfWsKa/Ulu7uWqA5/8hHXyeWgbj1X3sTBY
nNhjf0/O7SzzeBAvAc6eeqE/aaLwaDlVfzbfPEayFOnum8iHnolsGKk6SCj5xTiX
yMDV0Uph0mh71zeU9uBxAsVTRFEo46GhrYkFdxnnd4zfvyIt8dx0LTCcUiP87R4j
kYJVRkin+EKT4G9j+p98HmHtaFKXdL9Uf2tDFdrkLaWLYID8nQZuUI6VmeIFwPS3
cK1GN6Ll
=kUa7
-----END PGP SIGNATURE-----

--3MMMIZFJzhAsRj/+--
