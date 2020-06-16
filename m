Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41F31FB1FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgFPNZ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 09:25:26 -0400
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:14659
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbgFPNZY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 09:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjrefQSsFvsma4445xd5P7WKZq7sUElwxmMKLgsAkNgn+RuDeqQl7bBU4Nx2iq1zEiQzj5F3ehAzVc+mVxHlbjv8xltIkV2yKP0lzJUybeF2mPqKVL4t3WqvpaYQr5YB8NPBgtac7gwbqvDHUAEL7d38C38f1vLMUPPOurFuqFnPyFdzETESE6lNttLqsX0ZJgQr2Tn6abnBZ1PFkR4f0XcDvLCRp5dSJyLqqFiUXAXNVMheJ+t8LqMucZpLfcAhRGB0NUs8gJNQIHkKJ0Y7tMryxH+t5XeZ/1Y1OjLDOVNElmhqJBoysrN6XdxP35NjhmHSTWjP0qur3x5lJl63Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqyZ8j/4Fu6igPw2WAljVW+vAEElfAV3OqzWmTV7jNQ=;
 b=eM7FtZMY2uDy17RqvVCM1PHpj1WtNvE8qneMpFH4TdhT6TPjlpmt8v+etvguYZYzw9eDCYpleB7XF81UCO/KsJg0N3zXGsG0+Frho6yQ0m+Tw56QqACT4+c+IhPH/6kTG19bpfYXzyFVLmp45SwlJRT8AEsHQqpr4ltvvfnWFKwb+HTxBmpvnO6HROp68aa1mQX/N2s71xVJjPYyz0fXk+0viJu72IDWDFXh1TcEt0pf6PsPn3iarMHhH8hvOqQ64pFqOEHvMBYhp4NfI83axJrdqbdJKPgAYKTjsHU7sWhrqfF4QOWW/4iG0iJOMMoqr7itnmD1gPhzhsiFUhk42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqyZ8j/4Fu6igPw2WAljVW+vAEElfAV3OqzWmTV7jNQ=;
 b=RQzz+4y7zKneXMhnJnAQW+jxGJQl/thfr2JDT3RQEaAu5oOFH0uEljEsGDWyet7OrPBdr3lilUp3H8KqNx1LK1e8Q+8gEB5iD6kpA8rosf+fESJpayfHJd7Dn0MtiCU1sh1YgK4WmWvjeZrp/1dfmGfHLEmx49bIycXcZO29Xg4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BYAPR08MB5704.namprd08.prod.outlook.com (2603:10b6:a03:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Tue, 16 Jun
 2020 13:25:19 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::1ea:2027:6d68:1609]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::1ea:2027:6d68:1609%5]) with mapi id 15.20.3109.021; Tue, 16 Jun 2020
 13:25:19 +0000
Subject: Re: BTRFS File Delete Speed Scales With File Size?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
 <db40ba19-8160-05fd-5d25-65dea81b36fa@knorrie.org>
 <d5379505-7dd1-d5bc-59e7-207aaa82acf6@panasas.com>
 <b95000b6-5bda-ae0c-6cab-47b4def39f7c@panasas.com>
 <1a88f0e4-3fd1-b0bc-308e-c12b9f64b46c@panasas.com>
 <20200616035640.GK10769@hungrycats.org>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Message-ID: <d832607a-bfba-4f52-7c4e-05e3decacbf5@panasas.com>
Date:   Tue, 16 Jun 2020 09:25:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
In-Reply-To: <20200616035640.GK10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:208:a8::23) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.20] (96.236.219.216) by MN2PR12CA0010.namprd12.prod.outlook.com (2603:10b6:208:a8::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Tue, 16 Jun 2020 13:25:18 +0000
X-Originating-IP: [96.236.219.216]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af425328-e379-4a43-d8c1-08d811f8b6db
X-MS-TrafficTypeDiagnostic: BYAPR08MB5704:
X-Microsoft-Antispam-PRVS: <BYAPR08MB57045CABE4F6E3937D030089C29D0@BYAPR08MB5704.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIlb3mzWQ1h/l/EnfzcFH0KsQ8mQli63+Tt4LswijPVPPUnPS1ACiapTEsCk5mvOvDTfBBKsHoz/RX7lwWTRRve3aggOjb3r8ePJyBE8QaYKHKQ3zfs8NmtJQVSin+PbYgyNCgU/D+Qc0hv4DrLRD8i4KFVpXqRx6coxFtgg48HPKGQ2ERs/1AfzaymRyTTQ3XUk9UjArBO2FcKuw3L+eTgHfQI/QjhDpfnMjNKyOxGZfn+AAt42yPmYETyu3KAPYBB139ZzUydHxqeHImpJrwxSOGBVXd3VH5GIFHcgFEK1ysG/poglmd3BFcrbN3S3xY35JdzhxC79ewxX2UnQ3cisucortowrurYtOu2KooOFXJ88UUwwVUhYVhSBCWlUCGeZg2XZMGQrFNkq8imFqoJolt0gYJHa4hY1O0hrUKmPeoc2LwH3alWl+UZuWPe9wVoOa/lx5miI5n7jwMVe/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(39840400004)(366004)(8936002)(31686004)(316002)(16576012)(8676002)(2616005)(4326008)(966005)(956004)(5660300002)(6916009)(26005)(52116002)(53546011)(16526019)(186003)(83380400001)(36756003)(66556008)(2906002)(66946007)(31696002)(66476007)(86362001)(6486002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 17K/8Xs03KiMcM8dHnt1+6zBMj2XH6wJ+Mn4Yh6YQCAZzSj0YuTWmKSGZU7uz9MckAq9M3Be8j6KTUfoUO/7DF/jDngEw/N018++gPNZf6016/ZXmZjIb27qTgVwbaWOFzSOwfuBNG9YAVpjtboGM/sRLa0dHECOf5JB9Rl3tUW0M3qv3mRc2E2ylbMWDxZ6m7cb4GNTk6wSmIj+t6pTsAxp4BWvhwlhlNfYdSB5wcESY4n7zj4OR9WZPPYjQZMkkzdmGDtH6GvBA69IbzL6xKXDZUZFUixfLO5AXymdmBbttAjbLiYVz7cB/GaRDUyzpAFzU4uUtlX0I3jL+/dO6MRQQl77V7Aj2JWpSDqULkW4Z15DkyoiODVLPrdaxJYCyt987WitVyWRWDqsVpszdo9siHMQGQY9uaRkT7rkRFQJ2rwoMK9mfh6CRp2bwHM4aol3AmcO4M6+jZEOL44L2/6KNplfREHvxkfFUkxHYxOQrojrkIbZgPcwWifC6zdi
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af425328-e379-4a43-d8c1-08d811f8b6db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 13:25:19.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xNbECfWXvtS29RG6OO4QEMKEfvqKSPmA+2ao300ueTLh/WAamHUr3iDsVJqYNEWCsLyNG7Z//sppPFsElgxwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5704
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

First and foremost Zygo, apologies for not having responded to your 
prior two emails.  I was alerted by a colleague that we'd gotten a 
response, and found that very unfortunately our MS filter had marked 
your emails as spam.  I've unmarked them so hopefully this doesn't 
happen in the future.

A few comments on prior emails, and then responses in-line:

40 threads is simply the max due to the nature of our OSD architecture. 
We can make good use of them in the case of heavy PFS metadata updates 
(which do not go to BTRFS), but yes, they can overwhelm spinning rust 
under very heavy deletion workloads.  We're looking into task queuing to 
throttle this.

We are less concerned about the ability to process deletes in O(1) or 
O(log(n)) time, and more concerned about not holding up foreground I/O 
while a number of them are processed (ideally in the background).


On 6/15/20 11:56 PM, Zygo Blaxell wrote:
>> 2. We find that speed to delete and fsync the directory on 4.12 is
>> equivalent to delete and then sync the entire filesystem.
> 
> I'm not quite sure how fsync() is relevant here--fsync() doesn't do
> anything about delayed refs, unless fsync() accidentally triggers a full
> sync (which I wouldn't expect to happen when fsyncing a simple unlink).

fsync is how we are guaranteeing that either a write or create has 
occurred to a new file, or a delete has been acknowledged by the 
underlying FS and will be rolled forward on power-fail.  We recognize 
there may be non-trivial work involved in rolling that forward on 
reboot, especially on spinners.  It was of interest because previously I 
was (wrongly, at least relative to our use of BTRFS in our PFS) timing 
both the remove and the full 'sync' together, rather than just the 
remove and the fsync of the housing directory.  I agree in 4.12 the 
dominant time is the remove, so switching didn't matter, but it does 
matter in 5.7, for reasons you elucidate elsewhere.

> 4.12 throttles unlink() to avoid creating huge backlogs of ref updates
> in kernel memory.  During the throttling, previously delayed refs
> (including ref updates caused by other threads) are processed by the
> kernel thread servicing the unlink() system call.
> 
> 5.7 doesn't throttle unlink(), so the unlink() system call simply queues
> delayed ref updates as quickly as the kernel can allocate memory.
> Once kernel memory runs out, unlink() will start processing delayed
> refs during the unlink() system call, blocking the caller of unlink().
> If memory doesn't run out, then the processing happens during transaction
> commit in some other thread (which may be btrfs-transaction, or some
> other unlucky user thread writing to the filesystem that triggers delayed
> ref processing).

The above is exactly the explanation I've been looking for.  Thank you!

> In both kernels there will be bursts of fast processing as unlink()
> borrows memory, with occasional long delays while unlink() (or some other
> random system call) pays off memory debt.  4.12 limited this borrowing
> to thousands of refs and most of the payment to the unlink() caller;
> in 5.7, there are no limits, and the debt to be paid by a random user
> thread can easily be millions of refs, each of which may require a page
> of IO to complete.

Are there any user-tunable settings for this in 4.12?  We would be 
extremely interested in bumping the outstanding refs in that version if 
doing so was as simple as a sysctl, hidden mount option, or something 
similar.

>> Any comments on when major change(s) came in that would impact these
>> behaviors would be greatly appreciated.
> 
> Between 4.20 and 5.0 the delayed ref throttling went away, which might
> account for a sudden shift of latency to a different part of the kernel.
> 
> The impact is that there is now a larger window for the filesystem to
> roll back to earlier versions of the data after a crash.  Without the
> throttling, unlink can just keep appending more and more ref deletes to
> the current commit faster than the disks can push out updated metadata.
> As a result, there is a bad case where the filesystem spends all of
> its IO time trying to catch up to metadata updates, but never successfully
> completes a commit on disk.
> 
> A crash rolls back to the previous completed commit and replays the
> fsync log.  A crash on a 5.0 to 5.7 kernel potentially erases hours of
> work, or forces the filesystem to replay hours of fsync() log when the
> filesystem is mounted again.  This requires specific conditions, but it
> sounds like your use case might create those conditions.

Yes, we might under the right end-user scenarios and just the right 
timed power-fail, but we have appropriate states for the PFS to cope 
with this that can include a very lengthy bring-up period, of which 
mounting BTRFS is already included.  Erasing acknowledged fsync'd work 
would be a breach of POSIX and concerning, but taking time on mount to 
replay things like this is both expected and something we do at a higher 
level in our PFS so we get it.

> Some details:
> 
> 	https://lore.kernel.org/linux-btrfs/20200209004307.GG13306@hungrycats.org/
> 
> 5.7 has some recent delayed ref processing improvements, but AFAIK
> the real fixes (which include putting the throttling back) are still
> in development.

All extremely helpful info Zygo.  Thank you again, and do let me know if 
there are any tunables we can play with in 4.12 to better mimic the 
behavior we're seeing in 5.7.  We'd be indebted to find out there were.

Best,

ellis
