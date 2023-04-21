Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86B26EB3E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 23:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjDUVs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 17:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjDUVsZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 17:48:25 -0400
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 14:48:23 PDT
Received: from mail.mailmag.net (mail.mailmag.net [199.192.20.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B3E92
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 14:48:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id CEC1015D0AD;
        Fri, 21 Apr 2023 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=dkim;
        t=1682113223; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to;
        bh=LpJTFqmdKSJK9G2lCr/saF37Lhqp5I0ej2tfshkAIvs=;
        b=DDvx+CAIdojStlTe0yrQCiHFmLJOVhJVmY8237ruMv/lIsdVN3Ve8roSOxQgvGxB8uBUx7
        IN2sp0e0juBz8EVvmuj3WVwvyP/TJ5nCIBTEe8u+Lz4BcxVSxtEv42qR3dZAleuUXsDQXU
        fREo3ZftO2gMhDxnjl69ldHYbyUYzad999u3BF/J4wij54BaLGvi10tvfQHfXOjampwOOz
        8LJKV92z9VDNzNAAbagWAxFz1m/jvtPEtfdb8VspHLiD+2LDQ3Xw0MNjNTl+9qElnuZf+i
        8jN1NmLeiTnTMHai7XUErG7MfcPEVtY6qp5bOCYHVCxDc8/mnWbsqtD1udiycQ==
From:   "joshua" <joshua@mailmag.net>
In-Reply-To: <59643ed9-3e51-f1b1-3719-a30c3c449f1d@dirtcellar.net>
Content-Type: text/plain; charset="utf-8"
Date:   Fri, 21 Apr 2023 14:40:10 -0700
Cc:     "Remi Gauvin" <remi@georgianit.com>, "Qu Wenruo" <wqu@suse.com>,
        dsterba@suse.cz, "linux-btrfs" <linux-btrfs@vger.kernel.org>
To:     waxhead@dirtcellar.net
MIME-Version: 1.0
Message-ID: <3d-64430280-9-3e3db080@90317688>
Subject: =?utf-8?q?Re=3A?= Does btrfs filesystem defragment -r also include the 
 =?utf-8?q?trees=3F?=
User-Agent: SOGoMail 5.8.2
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Friday, April 21, 2023 10:41 PDT, waxhead <waxhead@dirtcellar.net> w=
rote:

> > On 2023-04-21 3:57 a.m., Qu Wenruo wrote:
> >>
> >=20
> >>
> >> I did a quick glance, btrfs=5Fdefrag=5Froot() only defrags the tar=
get
> >> subvolume, thus there is no way to defrag internal trees.
> >>
> >=20
> > It did *something* that allows Nautilus and Nemo to navigate a larg=
e
> > directory structure without stalling for > 10 seconds when moving b=
ack
> > and forth between subdirectories.
> >=20
> Are you sure that it is not just files being cached?
>=20
> If you run something like find -type f | parallel md5sum{} on the=20
> directory/subvolume you can see if it has the same effect.

It's definitely not ONLY files being cached.

I have a large array with 13 HDD's in it, and a total of 53GB of metada=
ta.
I constantly have issues with the mount time being so long that Linux t=
imes out and drops to recovery mode.

However, if I regularly run `btrfs fi defrag` on each of my sub-volumes=
 and the root volume, it makes a noticeable difference to mount time.  =
(Though still bad enough I gave up trying to have systemd mount my arra=
y and start my services.)

--=20
--Joshua Villwock

