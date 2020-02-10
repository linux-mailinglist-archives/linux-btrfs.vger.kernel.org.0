Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBBE157178
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgBJJMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 04:12:50 -0500
Received: from mail.synology.com ([211.23.38.101]:49016 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbgBJJMu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 04:12:50 -0500
Received: from _ (localhost [127.0.0.1])
        by synology.com (Postfix) with ESMTPA id BC63CDB1819F;
        Mon, 10 Feb 2020 17:12:48 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1581325968; bh=kRz7zuzDH6uzUhVHJjrFqNDa3Nh/zMl7jU+W4GFZUsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=rtqRp3zvqbusKE/PKJ+82sv9NQ0Rd7zDGHOH0LNcc1HFznZ77NqpNfskjPdsGwOst
         1x7s7zDVo8FXfY1LLSnVh6ul3p5ctBudy3TK7GZHJMSslI9CBBquLqLyNbvW9YaHar
         GwxGZfYXLtd05Vy2MwTTS2fbF0LnQeCRm5QoQAhc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 10 Feb 2020 17:12:48 +0800
From:   ethanwu <ethanwu@synology.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: backref, only collect file extent items
 matching backref offset
In-Reply-To: <0badf0be-d481-10fb-c23d-1b69b985e145@toxicpanda.com>
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-2-ethanwu@synology.com>
 <0badf0be-d481-10fb-c23d-1b69b985e145@toxicpanda.com>
Message-ID: <c0453c3eb7c9b4e56bd66dbe647c5f0a@synology.com>
X-Sender: ethanwu@synology.com
User-Agent: Roundcube Webmail/1.1.2
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Josef Bacik 於 2020-02-08 00:26 寫到:
> On 2/7/20 4:38 AM, ethanwu wrote:
>> When resolving one backref of type EXTENT_DATA_REF, we collect all
>> references that simply references the EXTENT_ITEM even though
>> their (file_pos- file_extent_item::offset) are not the same as the
>> btrfs_extent_data_ref::offset we are searching.
>> 
>> This patch add additional check so that we only collect references 
>> whose
>> (file_pos- file_extent_item::offset) == btrfs_extent_data_ref::offset.
>> 
>> Signed-off-by: ethanwu <ethanwu@synology.com>
> 
> I just want to make sure that btrfs/097 passes still right?  That's
> what the key_for_search thing was about, so I want to make sure we're
> not regressing.  I assume you've run xfstests but I just want to make
> doubly sure we're good here. If you did then you can add
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks,
> 
> Josef

Thanks for reviewing.

I've run the btrfs part of xfstests, 097 passed.
Failed at following tests:
074 (failed 2 out of 5 runs),
139, 153, 154,
197, 198(Patches related to these 2 tests seem to be not merged yet?)
201, 202

My kernel environment is 5.5-rc5, and this branch doesn't contain
fixes for tests 201 and 202.
All these failing tests also failed at the same version without my 
patch.

Thanks,
ethanwu

