Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2632DCC5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 07:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgLQGJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 01:09:13 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:37572 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgLQGJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 01:09:12 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 3AD7444A23D;
        Thu, 17 Dec 2020 08:08:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1608185305; bh=z78PXojKnqO5QfZiGMqkofezLUDpkMRZUHm4BtQO21c=;
        h=References:From:To:Cc:Subject:In-reply-to:Date;
        b=BW4fl5fMAv0A0bhut8Hotq3ZwQmwPw/dDZ2lVXEmDL5wV7c0F2g6HwsbQ5EHQZ1iR
         Rzh35mq+5PVAvDY8JuRBAeTh98ru2CfoBkZPF+bMqHfL6hnc0XpCv8k8OYMz9mdBCg
         ScD9x9kYTOlJMsRecgRugeRVEHWxNksb/FcmZJTA=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 2A0D844A23C;
        Thu, 17 Dec 2020 08:08:25 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id o-nqwVMZA-Qx; Thu, 17 Dec 2020 08:08:24 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id C851844A23A;
        Thu, 17 Dec 2020 08:08:24 +0200 (EET)
Received: from nas (unknown [117.89.173.90])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 0B10C1BE0090;
        Thu, 17 Dec 2020 08:08:19 +0200 (EET)
References: <20201217045737.48100-1-wqu@suse.com>
 <20201217045737.48100-3-wqu@suse.com> <k0thhu00.fsf@damenly.su>
 <ee628954-63db-2328-9d47-b1f0ed3bd8a7@gmx.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: inode: remove variable shadowing in
 btrfs_invalidatepage()
In-reply-to: <ee628954-63db-2328-9d47-b1f0ed3bd8a7@gmx.com>
Message-ID: <h7olhsmr.fsf@damenly.su>
Date:   Thu, 17 Dec 2020 14:08:12 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: 885mlYtJBDatlF+mQGXXBRpE0ScJA635mZS30wEq73aJTzLmCkUMVhC2n2R1THi+og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Thu 17 Dec 2020 at 13:42, Qu Wenruo <quwenruo.btrfs@gmx.com>=20
wrote:

> On 2020/12/17 =E4=B8=8B=E5=8D=881:38, Su Yue wrote:
>>
>> On Thu 17 Dec 2020 at 12:57, Qu Wenruo <wqu@suse.com> wrote:
>>
>>> In btrfs_invalidatepage() we re-declare @tree variable as
>>> btrfs_ordered_inode_tree.
>>>
>>> Remove such variable shadowing which can be very confusing.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>  fs/btrfs/inode.c | 9 +++------
>>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index dced71bccaac..b4d36d138008 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -8169,6 +8169,7 @@ static void btrfs_invalidatepage(struct=20
>>> page
>>> *page, unsigned int offset,
>>>                   unsigned int length)
>>>  {
>>>      struct btrfs_inode *inode =3D BTRFS_I(page->mapping->host);
>>> +    struct btrfs_ordered_inode_tree *ordered_tree =3D
>>> &inode->ordered_tree;
>>>
>> Any reason for the declaration here? I didn't find that=20
>> patch[3/4] use it.
>
> Didn't that ordered_tree get used lines below?
>
>>
>>>      struct extent_io_tree *tree =3D &inode->io_tree;
>>>      struct btrfs_ordered_extent *ordered;
>>>      struct extent_state *cached_state =3D NULL;
>>> @@ -8218,15 +8219,11 @@ static void=20
>>> btrfs_invalidatepage(struct page
>>> *page, unsigned int offset,
>>>           * for the finish_ordered_io
>>>           */
>>>          if (TestClearPagePrivate2(page)) {
>>> -            struct btrfs_ordered_inode_tree *tree;
>>> -
>> Better to just rename the @tree to @ordered_tree.
>
> Isn't that exactly what I did?

What I mean is that keep the declaration in the block since no=20
further use of it.

>
> Thanks,
> Qu
>>
>>> -            tree =3D &inode->ordered_tree;
>>> -
>>> -            spin_lock_irq(&tree->lock);
>>> +            spin_lock_irq(&ordered_tree->lock);
>>>              set_bit(BTRFS_ORDERED_TRUNCATED,=20
>>>              &ordered->flags);
>>>              ordered->truncated_len =3D=20
>>>              min(ordered->truncated_len,
>>>                      start - ordered->file_offset);
>>> -            spin_unlock_irq(&tree->lock);
>>> +            spin_unlock_irq(&ordered_tree->lock);
>>>
>>>              ASSERT(end - start + 1 < U32_MAX);
>>>              if (btrfs_dec_test_ordered_pending(inode,=20
>>>              &ordered,
>>

