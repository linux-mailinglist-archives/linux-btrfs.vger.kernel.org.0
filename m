Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FF629DB05
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 00:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgJ1Xmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 19:42:45 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55835 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbgJ1XlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 19:41:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C83785C00B5;
        Wed, 28 Oct 2020 19:41:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 28 Oct 2020 19:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:cc:subject
        :from:to:date:message-id:in-reply-to; s=fm1; bh=jkOO0zzQx5z5ACd/
        f32hxUtd46BMyxC0SJJR92tp714=; b=Pw2kO0jft/M2+0fUAsIArbdVk6RgFBn3
        tm8kGF3PWt8p9IYoTN2DLoL9v/EmRyX4VKCuDE+buFoPpdQ1zbBd73w9pxQrdxsi
        irpjYcj2lOmgOVXqOUMW9urxvlOS+lEMl9dLhJh++7qo6DI1d+ciGpp1Kd2F9kEV
        Gn/S3gzmKdIt/vvKdh5/8xrzHSnJHy61oJQKhxKVbEC+UkpJ+wkcorTzZyewjY4l
        uHqLp02MFV4jITiOmBf1IWCGtB24ou5LxeItJm9QKOOuErH6g3rhOdOBQMuIkG70
        mAgl5ufPu6O9f+YisIhfVZ1EE0/0l52ldmoaARib+nWdIF1vn/SE3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=jkOO0zzQx5z5ACd/f32hxUtd46BMyxC0SJJR92tp714=; b=AGjiDKeK
        c1kfM7JjN6nWI41h3EKxJvQejFehWo7MTvxazW04cDBJNSE4hWNsymQIfkBfF49y
        NC+TIHhH3twuZIP7CQFcKd6/ZDAw8m28or7bPZN7ntM851gT2UpbtQVEfWP4nOrM
        x5w+3iiio0uwOZJEOHBVxJbwBb6AtIoAO9enfkTZRB6WV/9zTYBgBrN4qHQ/YbdD
        oiiFKmoEWR7HaxZY55kWlEkDhO4A5HVwUAhX+yrDxvc8CfVNwHV5O7h4UeB2vNB5
        mQc4flbHEdeVBjDVV+ELfRICTuMWT6kqUzxDKxhI6jhuaTSurjC20Ojgxx8I4gB/
        qEDH1AzYZaZ6kQ==
X-ME-Sender: <xms:jwGaX-B19VWM0MNOb5hhWefmw5w3yCOLhmOcq46_8u4wxDYMYlVmuA>
    <xme:jwGaX4iM4FPQdf8on-XP3I-ODNLIT8qKt6G3nJJm7B7PrD-mUQyFIsYknHb14meYC
    wSWBUtQvjJGPYhynw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrledvgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepggfgtgfuhffvfffkjgesthhqredttddtjeen
    ucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeejfefhudeffefhjedvvefhheduledtueejvedugedvjedvjeel
    jefggedtjeejveenucfkphepudeifedruddugedrudefvddrheenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:jwGaXxlenumzoHOpnsXTVIlHJDeSE-c8k3gwdHA0VJ8qS7kLko-zNA>
    <xmx:jwGaX8zy53IZjx8wsbUtpRg_9_BRRSSk7mJZew06c4-_VClkQi8Njw>
    <xmx:jwGaXzRtOUnVdnWI4gKHdN94olk91asLqKjhM5CuEJyLfnsD3AWSgw>
    <xmx:jwGaX-dsiezrHbPDJfA-DITP9BVd8zMvi9eoojfkZcexiAa15hIVLQ>
Received: from localhost (unknown [163.114.132.5])
        by mail.messagingengine.com (Postfix) with ESMTPA id 657523064683;
        Wed, 28 Oct 2020 19:41:02 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <kernel-team@fb.com>, <osandov@fb.com>
Subject: Re: [PATCH] btrfs-progs: restore: Have -l display subvolume name
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Josef Bacik" <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <dsterba@suse.cz>
Date:   Wed, 28 Oct 2020 16:34:51 -0700
Message-Id: <C6OX21C3YSLT.X276V4IA7JPM@dlxu-fedora-R90QNFJV>
In-Reply-To: <8988a20e-a3e3-6bf3-dc7a-21b2706e7cf6@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Josef,

On Tue Oct 27, 2020 at 10:37 AM PDT, Josef Bacik wrote:
> On 10/26/20 8:28 PM, Daniel Xu wrote:
> > This commit has `btrfs restore -l ...` display subvolume names if
> > applicable. Before, it only listed subvolume IDs which are not very
> > helpful for the user. A subvolume name is much more descriptive.
> >=20
> > Before:
> > 	$ btrfs restore ~/scratch/btrfs/fs -l
> > 	 tree key (EXTENT_TREE ROOT_ITEM 0) 30425088 level 0
> > 	 tree key (DEV_TREE ROOT_ITEM 0) 30441472 level 0
> > 	 tree key (FS_TREE ROOT_ITEM 0) 30736384 level 0
> > 	 tree key (CSUM_TREE ROOT_ITEM 0) 30474240 level 0
> > 	 tree key (UUID_TREE ROOT_ITEM 0) 30785536 level 0
> > 	 tree key (256 ROOT_ITEM 0) 30818304 level 0
> > 	 tree key (257 ROOT_ITEM 0) 30883840 level 0
> > 	 tree key (DATA_RELOC_TREE ROOT_ITEM 0) 30490624 level 0
> >=20
> > After:
> > 	$ ./btrfs restore ~/scratch/btrfs/fs -l
> > 	 tree key (EXTENT_TREE ROOT_ITEM 0) 30425088 level 0
> > 	 tree key (DEV_TREE ROOT_ITEM 0) 30441472 level 0
> > 	 tree key (FS_TREE ROOT_ITEM 0) 30736384 level 0
> > 	 tree key (CSUM_TREE ROOT_ITEM 0) 30474240 level 0
> > 	 tree key (UUID_TREE ROOT_ITEM 0) 30785536 level 0
> > 	 tree key (256 ROOT_ITEM 0) 30818304 level 0 subvol1
> > 	 tree key (257 ROOT_ITEM 0) 30883840 level 0 subvol2
> > 	 tree key (DATA_RELOC_TREE ROOT_ITEM 0) 30490624 level 0
> >=20
>
> Man I stared at this a few times before I realized the name came after
> the
> previous information. I think I'd rather move this helper into somewhere
> that
> it can be used by the libbtrfs stuff, I'm sure it'll be handy elsewhere.

libbtrfsutil seems structured to work on mounted filesystem images
whereas `btrfs restore` is for unmounted images. So I'm not sure if
libbtrfsutil would want to share that code.

Does it make sense to put the helper in common/util.c instead?

I CC'd Omar in case he has an opinion.

Thanks,
Daniel
