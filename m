Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06872C938B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Dec 2020 01:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgLAACy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 19:02:54 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41003 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbgLAACy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 19:02:54 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id DBCD75C01AD;
        Mon, 30 Nov 2020 19:01:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 30 Nov 2020 19:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm2; bh=OIucWCzI/cp000ddfM5NA7FBrnn+DiNqK/09dCkK
        hhE=; b=MpbB+pVTpoU2umS1OiBELRTCrpwh4c3pT33FRPOSM5BMaeteUJAER43q
        mZgCHZmw0ORaRgnK5jfcTJwFokgcqoH7MgKrhzYbw3XcJtolF4McV99E1wRGZdsX
        G+7yWSrnnaptWDJ2jkU98zKsRKCKHYgI5oaf6XgYcijtowg5IA7Tz/nqpB5Pi6ur
        +bcp7aQTd+tOrQcRqb1Z9+7SeIS1auNWAKRmxIkhwrcc6dvcs91g/B8aO8acu5la
        sh8w3FGOZpmfhZVSm1MnuUJjFXVl5miZa7OoLcgN5CWMWMe4VsX+AeFQFmvXVDjK
        brGAAOynwJvOtN18oXltZFi9VrXqLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OIucWC
        zI/cp000ddfM5NA7FBrnn+DiNqK/09dCkKhhE=; b=E5wNSZ8nDahplwvAfT84GM
        vARTDLQ7MXGd+Jicuxfu+gm8XNVDfN97zcSo65jhJgojA6PlNyIHFufgRQYgSM+D
        PRHexe4SAKORzHweRbRhWrDNyZpkHJhu/xuZGTYwefXCCFSWgicKtq7yMMpvBYEY
        VXwrQXTh/zPE8u6566PAOorQ+dxZwP36j/D13sHKkO1TolqZGit7SmvD89XinW+8
        ySGk4TXxVMblekjozuwCce+djtptGybA9Q6AnFulLPcjvaM0BvOVqciE8+YN4+pO
        EC9N9fIoTlYOSiAoRAkf7U6r5ZvdRi+1rqAqAyli7WD5qWdssw6G2OZhy87+OCpw
        ==
X-ME-Sender: <xms:64fFX8Ny50R4ZvkBJB0cY4cFOn_rYvbSKE66n2u_QLtbmkVCJOPU9A>
    <xme:64fFXy8rYXXMfoijaDdc09vYGd0NRZx07y6FpfC7scHfmHpii4I9GqfxYMvLewzPS
    UWVeFKTd_cfYKmcHRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeiuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepvdfhgffhteeugefgtdegudevudegkeeguedvvd
    fhudegudfhteekvedtiedtgeeunecukfhppeduieefrdduudegrddufedvrdefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:64fFXzT138-w7_ch447sAFXKf83sBUOwUczl37DFyz3oIRbKb-blTA>
    <xmx:64fFX0uLeyGDgYGqQwR0e8A4j_FltPhD_4hxWEhJUuIiVl8RWBLxoQ>
    <xmx:64fFX0d1J_CXxQ2H5MlwrrE-y5WXaLsG46beITam4kC_v-1jRVihCg>
    <xmx:64fFX8kE-8kMOm5G07Xz-VqFlgKg9BxD4fVLUp4F38UYsYUlw2oANA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id EC6943064AB4;
        Mon, 30 Nov 2020 19:01:46 -0500 (EST)
Date:   Mon, 30 Nov 2020 16:01:38 -0800
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 01/12] btrfs: lift rw mount setup from mount and
 remount
Message-ID: <20201201000138.GB3661143@devbig008.ftw2.facebook.com>
References: <cover.1605736355.git.boris@bur.io>
 <ac259f3ceafae5a8bb9b6c554375588705aa55b2.1605736355.git.boris@bur.io>
 <20201123165704.GG8669@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123165704.GG8669@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 23, 2020 at 05:57:04PM +0100, David Sterba wrote:
> On Wed, Nov 18, 2020 at 03:06:16PM -0800, Boris Burkov wrote:
> > +/*
> > + * Mounting logic specific to read-write file systems. Shared by open_ctree
> > + * and btrfs_remount when remounting from read-only to read-write.
> > + */
> > +int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
> 
> The function could be named better, to reflect that it's starting some
> operations prior to the rw mount. As its now it would read as "mount the
> filesystem as read-write", we already have 'btrfs_mount' as callback for
> mount.
> 
> As this is a cosmetic fix it's not blocking the patchset but I'd like to
> have that fixed for the final version. I don't have a suggestion for
> now.

I agree, the name implies a function which does a rw mount end to end.

Some alternative ideas:
btrfs_prepare_rw_mount
btrfs_setup_rw_mount
btrfs_handle_rw_mount
btrfs_process_rw_mount

I think I personally like 'prepare' the most out of those.
