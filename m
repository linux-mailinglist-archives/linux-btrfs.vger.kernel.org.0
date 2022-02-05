Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0E64AA851
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 12:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbiBELWC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Feb 2022 06:22:02 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:35196 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiBELWB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Feb 2022 06:22:01 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 480381E00452;
        Sat,  5 Feb 2022 13:22:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1644060120; bh=kh7Y5mMOb/WsQQ4Gj/OmnLZsX5jQzZdJGuuPpT42/Y4=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date:to:cc;
        b=qYdwAbhwhDk2pQ0Cp6BvUNfyMNO7ncQS0T/GlxZsenxEPVnTQksl4hHl9jOP8Yv4e
         xoSnbp0fjVbxUHVR7FI/7SiIFLK+ZYj5WOE5miLhHfI2bAbgujsQD2/3ZnNmL5ijxU
         PxVEW9sdDnu/rIvgy9bq4vOVKF/gk5MaBljwbB/c=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 3FAFB1E00448;
        Sat,  5 Feb 2022 13:22:00 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id nSQoc6e2TDdF; Sat,  5 Feb 2022 13:21:59 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 6D4E31E000DE;
        Sat,  5 Feb 2022 13:21:59 +0200 (EET)
References: <20220121093335.1840306-3-l@damenly.su>
 <20220205111348.9D4B.409509F4@e16-tech.com>
 <20220205123520.77B3.409509F4@e16-tech.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: tree-checker: check item_size for dev_item
Date:   Sat, 05 Feb 2022 19:15:18 +0800
In-reply-to: <20220205123520.77B3.409509F4@e16-tech.com>
Message-ID: <ee4h36eo.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m7upSaUCpygHhXwK+CAc3rDRIWO/7+uO7zh9ZmGeYQiOGYip5XRGxnW10RX+5ujkX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sat 05 Feb 2022 at 12:35, Wang Yugui <wangyugui@e16-tech.com> 
wrote:

> Hi,
>
>> A btrfs filesystem failed to boot with this patch.
>>
>> corrupt leaf: root=3 block=1081344 slot=0 devid=1 invalid item 
>> size: has 0 expect 98
>>
>> Any way to fix it online?
>
> This btrfs filesystem is created by centos 7.9 installer (btrfs 
> 4.9?)
> about 1 years ago.  and then mainly writen by kernel 
> 5.4/5.10/5.15.
>
Yes, btrfs-progs v4.9 and v3.10 based kernel.
I created a btrfs and it looks fine.
Could please provide output of
btrfs inspect-internal dump-tree $device -t 3
?
You can trim it if the content is too long only leaf 1081344 is 
needed.


--
Su

> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/02/05
>
>
>>
>> > Check item size before accessing the device item to avoid out 
>> > of bound
>> > access.
>> >
>> > Signed-off-by: Su Yue <l@damenly.su>
>> > ---
>> >  fs/btrfs/tree-checker.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/fs/btrfs/tree-checker.c 
>> > b/fs/btrfs/tree-checker.c
>> > index 2978fc89c093..87fff4345977 100644
>> > --- a/fs/btrfs/tree-checker.c
>> > +++ b/fs/btrfs/tree-checker.c
>> > @@ -965,6 +965,7 @@ static int check_dev_item(struct 
>> > extent_buffer *leaf,
>> >  			  struct btrfs_key *key, int slot)
>> >  {
>> >  	struct btrfs_dev_item *ditem;
>> > +	u32 item_size = btrfs_item_size(leaf, slot);
>> >
>> >  	if (unlikely(key->objectid != BTRFS_DEV_ITEMS_OBJECTID)) {
>> >  		dev_item_err(leaf, slot,
>> > @@ -972,6 +973,13 @@ static int check_dev_item(struct 
>> > extent_buffer *leaf,
>> >  			     key->objectid, 
>> >  BTRFS_DEV_ITEMS_OBJECTID);
>> >  		return -EUCLEAN;
>> >  	}
>> > +
>> > +	if (unlikely(item_size != sizeof(*ditem))) {
>> > +		dev_item_err(leaf, slot, "invalid item size: 
>> > has=%u expect=%zu",
>> > +			     item_size, sizeof(*ditem));
>> > +		return -EUCLEAN;
>> > +	}
>> > +
>> >  	ditem = btrfs_item_ptr(leaf, slot, struct btrfs_dev_item);
>> >  	if (unlikely(btrfs_device_id(leaf, ditem) != key->offset)) 
>> >  {
>> >  		dev_item_err(leaf, slot,
>> > --
>> > 2.34.1
>>
