Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC4375F95
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 May 2021 06:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhEGE6n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 May 2021 00:58:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232410AbhEGE6m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 May 2021 00:58:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1474XRmE007494;
        Fri, 7 May 2021 00:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wGJhDNB+D9uB/A2YRYqsDJajoOvsgFAOrheCe5dJdcU=;
 b=mj37LEfTzy0MD8yfQJrpAAKQPthQ00ot3AU0/4/vxVzoEgHZZ0YGAw8mI/GkvoFTBcMR
 MgGBDHXdMwPmZw7NbrjduDJG8Dvx1bXiyNUe0E1DfCvBxlOK/H8N5T3ahJq8EU1STMNI
 VQvKWNkgd1AqHjMcJe9GyBHQTN/AzULPmKtlsGUIv4Sr1tbhTyODfqAEeLpCDwjFuTfk
 gyTFQ02SB/ZbzpMFxSs7EKg2Lp45TH88bsfihU5GspGV/Ev0EAy1fGQ/jRAwBBkxEUF4
 kNp9OnQIVhFD25L9G2G8lnNwpjNQ9YPVuVB3E399rbvF/WIyQprfAf0lmQNScOPhXVyz rA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38cx6r8wg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 May 2021 00:57:40 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1474sZ3h003233;
        Fri, 7 May 2021 04:57:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 38csqa02p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 May 2021 04:57:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1474vaTT42205570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 May 2021 04:57:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53A18A4055;
        Fri,  7 May 2021 04:57:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0215FA4053;
        Fri,  7 May 2021 04:57:36 +0000 (GMT)
Received: from localhost (unknown [9.199.57.74])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 May 2021 04:57:35 +0000 (GMT)
Date:   Fri, 7 May 2021 10:27:35 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <20210507045735.jjtc76whburjmnvt@riteshh-domain>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-42-wqu@suse.com>
 <46a8cbb7-4c3a-024d-4ee3-cbeb4068e92e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46a8cbb7-4c3a-024d-4ee3-cbeb4068e92e@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hVW15ZYi32GmQMXEya_Qafc9c4xIMmPS
X-Proofpoint-ORIG-GUID: hVW15ZYi32GmQMXEya_Qafc9c4xIMmPS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_16:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105070031
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/07 07:46AM, Qu Wenruo wrote:
>
>
> On 2021/4/28 上午7:03, Qu Wenruo wrote:
> > [BUG]
> > There is a possible use-after-free bug when running generic/095.
> >
> >   BUG: Unable to handle kernel data access on write at 0x6b6b6b6b6b6b725b
> >   Faulting instruction address: 0xc000000000283654
> >   c000000000283078 do_raw_spin_unlock+0x88/0x230
> >   c0000000012b1e14 _raw_spin_unlock_irqrestore+0x44/0x90
> >   c000000000a918dc btrfs_subpage_clear_writeback+0xac/0xe0
> >   c0000000009e0458 end_bio_extent_writepage+0x158/0x270
> >   c000000000b6fd14 bio_endio+0x254/0x270
> >   c0000000009fc0f0 btrfs_end_bio+0x1a0/0x200
> >   c000000000b6fd14 bio_endio+0x254/0x270
> >   c000000000b781fc blk_update_request+0x46c/0x670
> >   c000000000b8b394 blk_mq_end_request+0x34/0x1d0
> >   c000000000d82d1c lo_complete_rq+0x11c/0x140
> >   c000000000b880a4 blk_complete_reqs+0x84/0xb0
> >   c0000000012b2ca4 __do_softirq+0x334/0x680
> >   c0000000001dd878 irq_exit+0x148/0x1d0
> >   c000000000016f4c do_IRQ+0x20c/0x240
> >   c000000000009240 hardware_interrupt_common_virt+0x1b0/0x1c0
> >
> > [CAUSE]
> > There is very small race window like the following in generic/095.
> >
> > 	Thread 1		|		Thread 2
> > --------------------------------+------------------------------------
> >    end_bio_extent_writepage()	| btrfs_releasepage()
> >    |- spin_lock_irqsave()	| |
> >    |- end_page_writeback()	| |
> >    |				| |- if (PageWriteback() ||...)
> >    |				| |- clear_page_extent_mapped()
> >    |				|    |- kfree(subpage);
> >    |- spin_unlock_irqrestore().
> >
> > The race can also happen between writeback and btrfs_invalidatepage(),
> > although that would be much harder as btrfs_invalidatepage() has much
> > more work to do before the clear_page_extent_mapped() call.
> >
> > [FIX]
> > For btrfs_subpage_clear_writeback(), we don't really need to put
> > end_page_writepage() call into the spinlock critical section.
> >
> > By just checking the bitmap in the critical section and call
> > end_page_writeback() outside of the critical section, we can avoid such
> > use-after-free bug.
> >
> > Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >   fs/btrfs/subpage.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> > index 696485ab68a2..c5abf9745c10 100644
> > --- a/fs/btrfs/subpage.c
> > +++ b/fs/btrfs/subpage.c
>
> Hi Ritesh,
>
> Unfortunately I have to bother you again for testing the latest subpage
> branch.

Yes, this was anyway on my mind to test the latest subpage branch.
Sure, I will do the testing.

>
> This particular fix seems to be incomplete, as I have hit several BUG_ON()s
> related to end_page_writeback() called on page without writeback flag.

ok.

>
> > @@ -420,13 +420,16 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
> >   {
> >   	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> >   	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
> > +	bool finished = false;
> >   	unsigned long flags;
> >   	spin_lock_irqsave(&subpage->lock, flags);
> >   	subpage->writeback_bitmap &= ~tmp;
> >   	if (subpage->writeback_bitmap == 0)
> > -		end_page_writeback(page);
> > +		finished = true;
> >   	spin_unlock_irqrestore(&subpage->lock, flags);
> > +	if (finished)
> > +		end_page_writeback(page);
>
> The race can happen like this:
>
>               T1                  |              T2
> ----------------------------------+----------------------------------
> __extent_writepage()              |
> |<< The 1st sector of the page >> |
> |- writepage_delalloc()           |
> |  Now the subpage range has      |
> |  Writeback flag                 |
> |- __extent_writepage_io()        |
> |  |- submit_extent_page()        | << endio of the 1st sector >>
> |                                 | end_bio_extent_writepage()
> |<< The 2nd sector of the page >> | |- spin_lock_irqsave()
> |- writepage_delalloc()           | |- finished = true
> |  |- spin_lock()                 | |- spin_unlock_irqstore()
> |  |- set_page_writeback();       | |
> |  |- spin_unlock()               | |- end_page_writeback()
> |                                 | << Now page has no writeback >>
> |- __extent_writepagE_io()        |
>    |- submit_extent_page()        | << endio of the 2nd sector >>
>                                   | end_bio_extent_writepage()
>                                   | |- finished = true;
>                                   | |- end_page_writeback()
>                                    !!! BUG_ON() triggered !!!
>
> The reproducibility is pretty low, so far I have only hit 3 times such
> BUG_ON().
> No special test case number for it, all 3 BUG_ON() happens for different
> test cases.
>
> Thus newer fix will still keep the end_page_writeback() inside the spinlock,
> but btrfs_releasepage() and btrfs_invalidatepage() will "wait" for the
> spinlock to be released before detaching the subpage structure.
>
> Currently the fix runs fine, but extra test will always help.

Sorry, just to be clear, do you mean the latest subpage branch still
has some issues where we can hit the BUG_ON() or have you identifed and added
some patches to fix it?

Let me clone below branch and re-test xfstests on Power.
https://github.com/adam900710/linux/commits/subpage

Also if you would like me to test any extra mount option or mkfs option testing
too, then pls do let me know. For now I will be testing with default options.

-ritesh
