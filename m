Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD15BA2BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 00:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIOWge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 18:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIOWgc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 18:36:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64884C614
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 15:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663281386;
        bh=XWhzSDVFDua63IQQKKqVYGgubQP06MPdUz0fg03XfrE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AI48RHjfOG3O1DKIZdBt2wikJf6r6Wj16x70LeEXw0uk+5vFDa7m/GHGGWb0filr3
         jFHZx6d8gjo4VfN4GbH0lAIZ11hjMmB0ViKxmJ9Fn/OB2VGPC7ZrtnNS1AinFnBK7F
         CH2xT9LcEpQl1leq1Aj2HjRP98QFVryS5RNxHi24=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowKc-1p6Lfr48FS-00qOEB; Fri, 16
 Sep 2022 00:36:26 +0200
Message-ID: <915a80ce-8a27-3472-3cbf-e871d1de65ab@gmx.com>
Date:   Fri, 16 Sep 2022 06:36:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/2] btrfs: refactor the inline extent read code inside
 btrfs_get_extent()
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1663229903.git.wqu@suse.com>
 <dc726a7d458d3100602b3507cbf2a236ac47ff55.1663229903.git.wqu@suse.com>
 <YyNHhayadq+RyH+w@localhost.localdomain>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YyNHhayadq+RyH+w@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VflbpRBXHPB4y08O+lnXPvDT6GxbsYI7C9wq5vDS1gWKbMAwmBD
 yRjfl2RdzK/vV/UELAA7EvkZhNDCdQhCY//UKCxqZu7tn2Cv4lMhV6BrGAJIiVX8ywVUTyM
 8BAzDOgJJOY+5CqWjhSutLsFvfbel9Phip30zdVhTNmNOVrOjZ8jZ6FxwyThjWBXAbl5k7H
 JxWkGDcHKOjbg1iUrfS4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:terHhPhfIC0=:KASiinznMHAsziVGln9Dc5
 d6Mlv5qPnFDexH6UielHFIpgd6PRDXotEiT+RCgViLinqkOubIMvtfKa5sG6IBWwXYprigLIi
 VjGRsjTH1TL84dh7fZm7O2dg3Qou4jl0+b1qonMdfhon+0U+AvQgjjXvjaq98QJfqtLGA9kzi
 Ca/QO7bawPv2YMaerFYDwlT+SPIUVinfPRJm6URMVs9sqHhgiqhk6FA0fRBXksUYZbnIt+NDf
 dJJFLoU2TTobjNLPGDFD//HFq+3tEhl0T0SRcZRi+pzGNPu4fUjTLjoeiYOxA6pfAX+iqM3HF
 9cI1SIZgr8o3we0DngT5t+e+RpNkUQujR4UiC8R7CUWiL9n4eIZfV36RvVKmQaELj0Q2a5Zc2
 aKaseUGartpsRttUOnArk289b4uxcliiDbC8jXW12wjkpDQxplDDwee9p3VPqd0F723zPHzyq
 jlE39+qQdGZoieDLvJw4E9y1POuZoLzUDk6uW9bC6QfyNX2INrKjlivlceuVwQDg0d5LIyn/J
 +348oCk7eRSaPhOxenJN8tgpAfJd350iDHFCrqkxHN8tlrAHj4E3cXMbcSrKg8tg06r0k4Avq
 yeEZSY/30y83nO27eCy6omc0L/l5yNiV6ozELKwfuX0fUqDlz2FtKb7bVKteh2VTpIBpdX8yb
 lxCiGPGvJA0CWmjOm/ItaWpAYV0BEYyJylnsoYpGPqlYix6F+zxs8Oir2NDZ66cFVR+ot0JlW
 gFpmyg70dOy43oOnwucRz5I9+m4N/MigYGBPoO99JxAvMaPfedNDAqr73C5jDOBR9e1LQaYQ1
 a/h1qNzOCBh8yuq6BPkVh4LpmXME7geIrEJfUXxOg77o5V6IsXZ1wpIE6P6BJhUSAK4oIy9yH
 MqoWrxjkcvx4CC2OnwL4k2jcRWzoGUZDyArP5ItKJSeO+BBiHdTyS3t+paoCaCVQbkx5kFYCI
 nl5JoS4Vx3ItfFHOok8BWI4uZUY1g/8kavSYEH+Hg3F+tuO9lPtKvNNZ09itj4T7vFsedZy8j
 kQdg9bATPMiKKv/LCXLcf8aWSxo2th4usA/fAqOxjKWMHBnQeefwYvTriOJYNlx3gd0hZlVEP
 1cweepBkJOU7nfID8VLrDlAg2rZK57/rPPKPEZhHRUdPReXmfeiLZS1thE6EzoAQtI9vCHA2z
 P+CC+HZfXZBcUbJBi3t0jscsng
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/15 23:40, Josef Bacik wrote:
> On Thu, Sep 15, 2022 at 04:22:51PM +0800, Qu Wenruo wrote:
>> [PROBLEM]
>> In btrfs_get_extent() we can fill the inline extent directly.
>>
>> But there are something not that straightforward for the functionality:
>>
>> - It's behind two levels of indent
>>
>> - It has a weird reset for extent map values
>>    This includes resetting:
>>    * em->start
>>
>>      This makes no sense, as our current tree-checker ensures that
>>      inline extent can only at file offset 0.
>>
>>      This means not only the @extent_start (key.offset) is always 0,
>>      but also @pg_offset and @extent_offset should also be 0.
>>
>>    * em->len
>>
>>      In btrfs_extent_item_to_extent_map(), we already initialize em->le=
n
>>      to "btrfs_file_extent_end() - extent_start".
>>      Since @extent_start can only be 0 for inline extents, and
>>      btrfs_file_extent_end() is already doing ALIGN() (which is roundin=
g
>>      up).
>>
>>      So em->len is always sector_size for inlined extent now.
>>
>>    * em->orig_block_len/orig_start
>>
>>      They doesn't make much sense for inlined extent anyway.
>>
>> - Extra complex calculation for inline extent read
>>
>>    This is mostly caused by the fact it's still assuming we can have
>>    inline file extents at non-zero file offset.
>>
>>    Such offset calculation is now a dead code which we will never reach=
,
>>    just damaging the readability.
>>
>> - We have an extra bool for btrfs_extent_item_to_extent_map()
>>
>>    Which is making no difference for now.
>>
>> [ENHANCEMENT]
>> This patch will enhance the behavior by:
>>
>> - Extract the read code into a new helper, read_inline_extent()
>>
>> - Much simpler calculation for inline extent read
>>
>> - Don't touch extent map when reading inline extents
>>
>> - Remove the bool argument from btrfs_extent_item_to_extent_map()
>>
>> - New ASSERT()s to ensure inline extents only start at file offset 0
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ctree.h     |  1 -
>>   fs/btrfs/file-item.c |  6 +--
>>   fs/btrfs/inode.c     | 93 +++++++++++++++++++++++++------------------=
-
>>   fs/btrfs/ioctl.c     |  2 +-
>>   4 files changed, 57 insertions(+), 45 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 05df502c3c9d..e8ce86516ec8 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -3356,7 +3356,6 @@ int btrfs_lookup_csums_range(struct btrfs_root *r=
oot, u64 start, u64 end,
>>   void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
>>   				     const struct btrfs_path *path,
>>   				     struct btrfs_file_extent_item *fi,
>> -				     const bool new_inline,
>>   				     struct extent_map *em);
>>   int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u6=
4 start,
>>   					u64 len);
>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>> index 29999686d234..d9c3b58b63bf 100644
>> --- a/fs/btrfs/file-item.c
>> +++ b/fs/btrfs/file-item.c
>> @@ -1196,7 +1196,6 @@ int btrfs_csum_file_blocks(struct btrfs_trans_han=
dle *trans,
>>   void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
>>   				     const struct btrfs_path *path,
>>   				     struct btrfs_file_extent_item *fi,
>> -				     const bool new_inline,
>>   				     struct extent_map *em)
>>   {
>>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>> @@ -1248,10 +1247,9 @@ void btrfs_extent_item_to_extent_map(struct btrf=
s_inode *inode,
>>   		 */
>>   		em->orig_start =3D EXTENT_MAP_HOLE;
>>   		em->block_len =3D (u64)-1;
>> -		if (!new_inline && compress_type !=3D BTRFS_COMPRESS_NONE) {
>> +		em->compress_type =3D compress_type;
>> +		if (em->compress_type !=3D BTRFS_COMPRESS_NONE)
>>   			set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
>> -			em->compress_type =3D compress_type;
>> -		}
>
> I spent most of my time reviewing this patch trying to decide if this ma=
ttered
> or not, why it was introduced in the first place, and if it was ok to ch=
ange.
> Additionally it's not related to the bulk of the change which is making =
the
> btrfs_get_extent thing cleaner.
>
> So break this out into it's own patch, with a detailed explanation of wh=
y this
> particular change is ok.  In fact I'd prefer if you made all changes to =
how we
> mess with the em their own changes, since bugs here can be super subtle,=
 I'd
> rather have more discreete areas to bisect to.  Thanks,

Sure, in fact I'm also a little unsure if I should put all these changes
into one patch.

Will split all these changes into separate ones.

Thanks,
Qu

>
> Josef
