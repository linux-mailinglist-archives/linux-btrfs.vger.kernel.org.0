Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E643957A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhEaI7S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:59:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40124 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhEaI7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:59:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5319E2191B;
        Mon, 31 May 2021 08:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zTUMNIX/EBaj+zqxRf98w8Ed/Wkv+kTFj4TwFaAJyCc=;
        b=tI+aQk73rNx+k0Tv73VcHsA9PP3smyI+jBPtDdvMnc85sKf1Xzy52XTFKgrCeBRHcLY4td
        m4M0sMHYKVKLotbObWqsugTTeqA4KXvnBN39aiwYUUwNB4xRrHPLhKEnLywDoxOq+aIe5R
        7+UrgINCjGkJbsKSbVyn0heC/AYx2JA=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B967A118DD;
        Mon, 31 May 2021 08:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zTUMNIX/EBaj+zqxRf98w8Ed/Wkv+kTFj4TwFaAJyCc=;
        b=Ivr5m7+3RgqtLNLoGzSap+1kFLpXBDlwPVyUrlPsn2/v31C1l4CPyUd5QcLGEu/ehkjksy
        NognUi9B5xoeUj/ExuC1J+NXxOz5SNMBGV/ajmhzO8kGuEtF035GNGNb9cnC/Z3yEL/LIZ
        p/7TJZJQuSJVvhFvYVZ2ZwFnMt1S70Q=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id h53MKvyktGBORgAALh3uQQ
        (envelope-from <nborisov@suse.com>); Mon, 31 May 2021 08:57:32 +0000
Subject: Re: [syzbot] kernel BUG in assertfail
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000f9136f05c39b84e4@google.com>
 <21666193-5ad7-2656-c50f-33637fabb082@suse.com>
 <CACT4Y+bqevMT3cD5sXjSv9QYM_7CwjYmN_Ne5LSj=3-REZ+oTw@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <224f1e6a-76fa-6356-fe11-af480cee5cf2@suse.com>
Date:   Mon, 31 May 2021 11:57:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bqevMT3cD5sXjSv9QYM_7CwjYmN_Ne5LSj=3-REZ+oTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: **
X-Spam-Score: 2.50
X-Spamd-Result: default: False [2.50 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9f3da44a01882e99];
         TAGGED_RCPT(0.00)[a6bf271c02e4fe66b4e4];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31.05.21 г. 11:55, Dmitry Vyukov wrote:
> On Mon, May 31, 2021 at 10:44 AM 'Nikolay Borisov' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
>> On 31.05.21 г. 10:53, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    1434a312 Merge branch 'for-5.13-fixes' of git://git.kernel..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=162843f3d00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9f3da44a01882e99
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a6bf271c02e4fe66b4e4
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
>>>
>>> assertion failed: !memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid, BTRFS_FSID_SIZE), in fs/btrfs/disk-io.c:3282
>>
>> This means a device contains a btrfs filesystem which has a different
>> FSID in its superblock than the fsid which all devices part of the same
>> fs_devices should have. This can happen in 2 ways - memory corruption
>> where either of the ->fsid member are corrupted or if there was a crash
>> while a filesystem's fsid was being changed. We need more context about
>> what the test did?
> 
> Hi Nikolay,
> 
> From a semantic point of view we can consider that it just mounts /dev/random.
> If syzbot comes up with a reproducer it will post it, but you seem to
> already figure out what happened, so I assume you can write a unit
> test for this.
> 

Well no, under normal circumstances this shouldn't trigger. So if syzbot
is doing something stupid as mounting /dev/random then I don't see a
problem here. The assert is there to catch inconsistencies during normal
operation which doesn't seem to be the case here.

