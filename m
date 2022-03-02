Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9E54C9BB0
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 04:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbiCBDEz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 22:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiCBDEy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 22:04:54 -0500
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 19:04:10 PST
Received: from p3plwbeout16-05.prod.phx3.secureserver.net (p3plsmtp16-05-2.prod.phx3.secureserver.net [173.201.193.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1925F4F7
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Mar 2022 19:04:10 -0800 (PST)
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id PFEynFxzcW8a9PFEznuidD; Tue, 01 Mar 2022 20:01:25 -0700
X-CMAE-Analysis: v=2.4 cv=RLN2o6u+ c=1 sm=1 tr=0 ts=621ede05
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=FXvPX3liAAAA:8
 a=lFWsI9-O6uv9ryMHa3YA:9 a=QEXdDO2ut3YA:10 a=SM4aVyO6fsoA:10
 a=OunuuIp3J4_2X_e7vt2U:22 a=fDQtvUcBV1mJc6yKnRhE:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  PFEynFxzcW8a9
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp11.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nPFEy-0008Mw-0N; Wed, 02 Mar 2022 03:01:24 +0000
Message-ID: <ac281c26-682c-b8b7-88b2-7e1b4669de5d@squashfs.org.uk>
Date:   Wed, 2 Mar 2022 03:01:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] squashfs: always use bio_kmalloc in squashfs_bio_read
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220301084552.880256-1-hch@lst.de>
 <20220301084552.880256-3-hch@lst.de>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20220301084552.880256-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfLxO3N42fNcgNhUG3GIM/Vk8TLlNG3HRmCszGnOWLQxl/Q1hjiRw2Y4PPg33OwkLAIdHsiI3GAYIcPkErpeYQwq3U+XXk6fEf/bbJ67SsAcVflkrpfld
 7pYmeJp1Mk7yV8shFuo+jB7irZSiP8UPIVoyzwTS7oju9gwIcb+K4GAPMjWAj8ICf1i/RpJBLJCpnAZRIzEtuE0C09ESLIHXmLJlVlt6/EKIcoOIILMd3u5t
 5PAo6XAEM98bU23U6eksSA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2022 08:45, Christoph Hellwig wrote:
> If a plain kmalloc that is not backed by a mempool is safe here for a
> large read (and the actual page allocations), it must also be for a
> small one, so simplify the code a bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Phillip Lougher <phillip@squashfs.org.uk>
