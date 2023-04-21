Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293836EB5BB
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Apr 2023 01:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjDUX0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 19:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjDUX0L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 19:26:11 -0400
Received: from mail.mailmag.net (mail.mailmag.net [199.192.20.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761E4E76
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 16:26:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 98C9415D0FA;
        Fri, 21 Apr 2023 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=dkim;
        t=1682119562; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to;
        bh=ZxocuFIUi4B6T4Ekcg7fHPxq1K8MvVMYPkJ0vVkImHM=;
        b=hKUPRc5QBbCsMtYIZVakTuDxFbZbv8t/qDdGU48c/zRjct609L5V3AR9iLCjWihiU+zzxs
        fIJ9coDb+aSwtjjekhYJZXZo3kHcoZ2iuannuzCISlb5DcpA9+rO480cL0cCO6K+kLyjdg
        7qbHqkBx8a6xfUrsZr5T7EUiLgqoKxyKOHKjoWsXjPjR5nNYyvGiCHmQQatxsAonbGlUGR
        5Z0weoFIS/B7LSC7ockazb9fke9rjNoyE1A7x5tQFuvkenP47YG7Pi2bw0Yzr87MOusPex
        WZxCzMhnG4kU75o6nHvwGmBncf8kIi5Fqujy4+E8R/Di86kiFFqEqCpcuLHi+Q==
From:   "joshua" <joshua@mailmag.net>
In-Reply-To: <d73d6032-fd56-e544-d011-3a5fb4f70a43@suse.com>
Content-Type: text/plain; charset="utf-8"
Date:   Fri, 21 Apr 2023 16:25:50 -0700
Cc:     waxhead@dirtcellar.net, "Remi Gauvin" <remi@georgianit.com>,
        dsterba@suse.cz, "linux-btrfs" <linux-btrfs@vger.kernel.org>
To:     "Qu Wenruo" <wqu@suse.com>
MIME-Version: 1.0
Message-ID: <44-64431b80-5-7f085200@250139773>
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

For my situation, (and others with large arrays) yes definitely.
It's definitely the feature I'm most interested in patiently waiting fo=
r....

--=20
--Joshua Villwock

On Friday, April 21, 2023 15:55 PDT, Qu Wenruo <wqu@suse.com> wrote:

>=20
>=20
> On 2023/4/22 05:40, joshua wrote:
> > On Friday, April 21, 2023 10:41 PDT, waxhead <waxhead@dirtcellar.ne=
t> wrote:
> >=20
> >>> On 2023-04-21 3:57 a.m., Qu Wenruo wrote:
> >>>>
> >>>
> >>>>
> >>>> I did a quick glance, btrfs=5Fdefrag=5Froot() only defrags the t=
arget
> >>>> subvolume, thus there is no way to defrag internal trees.
> >>>>
> >>>
> >>> It did *something* that allows Nautilus and Nemo to navigate a la=
rge
> >>> directory structure without stalling for > 10 seconds when moving=
 back
> >>> and forth between subdirectories.
> >>>
> >> Are you sure that it is not just files being cached?
> >>
> >> If you run something like find -type f | parallel md5sum{} on the
> >> directory/subvolume you can see if it has the same effect.
> >=20
> > It's definitely not ONLY files being cached.
> >=20
> > I have a large array with 13 HDD's in it, and a total of 53GB of me=
tadata.
> > I constantly have issues with the mount time being so long that Lin=
ux times out and drops to recovery mode.
>=20
> Then bg tree would be the ultimate solution.
>=20
> >=20
> > However, if I regularly run `btrfs fi defrag` on each of my sub-vol=
umes and the root volume, it makes a noticeable difference to mount tim=
e.  (Though still bad enough I gave up trying to have systemd mount my =
array and start my services.)
> >

