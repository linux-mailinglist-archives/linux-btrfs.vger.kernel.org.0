Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892C9576E88
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jul 2022 16:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiGPO1I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jul 2022 10:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiGPO1G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jul 2022 10:27:06 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Jul 2022 07:27:04 PDT
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDAA205DD
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jul 2022 07:27:04 -0700 (PDT)
Received: from [192.168.1.27] ([94.34.5.22])
        by smtp-17.iol.local with ESMTPA
        id Cik4o9e7KX0RaCik4opwpe; Sat, 16 Jul 2022 16:26:01 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1657981561; bh=imad4rt5v0XNOJRvXtQg517PpHwAb5CXqjXHQqHivZA=;
        h=From;
        b=sGay+CWKpWj7VR/wXxMN57fLGZJOxUWvNPakT9DLOiRQrAWwlXhRM+MB0UE1IVvDt
         i6FsF3XL1RY4Txr9/N10N/KgTgi53QOml2EuYdkKR9WZET+qwxARpHhr7vjyBAZb8M
         k6FjMMf2iDAr+SRA90hxzDLdQK9jXOyGXDJKeZEjRYttN8hIkmg0w/SLig1qGER1ck
         faXT6kph0BCphtpBaQy0QeOVlmfPVbzX3LLDEky39EVDGngXWqEcHavNBHuLVU6Zi0
         elZus8Lo1octAiHDIZDiP4NUQ9+1WO8Mua3x4MNEKtdeAlZA5aouK3yZtzf+PiFR/s
         kAInskrxE8FJQ==
X-CNFS-Analysis: v=2.4 cv=P7T/OgMu c=1 sm=1 tr=0 ts=62d2ca79 cx=a_exe
 a=hwDnfLutCD/4BcDojJwT2A==:117 a=hwDnfLutCD/4BcDojJwT2A==:17
 a=IkcTkHD0fZMA:10 a=uVAMYxe_6ymgrK7H_xsA:9 a=QEXdDO2ut3YA:10
Message-ID: <d49eca7a-74be-c3a9-a70b-055e9e37bcc2@inwind.it>
Date:   Sat, 16 Jul 2022 16:26:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Reply-To: kreijack@inwind.it
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
To:     Thiago Ramon <thiagoramon@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAO1Y9woJUhuQ+Q2yWSvscnBJb9D5cYiBaY-WG3Re=7V=OzWVhw@mail.gmail.com>
 <1dcfecba-92fc-6f49-bdea-705896ece036@gmx.com>
 <928e46e3-51d2-4d7a-583a-5440f415671e@gmx.com>
 <CAO1Y9woENiZOokwqSeSbmr30w7ksw+ZkXUR9pU68Kmfm8X+K=g@mail.gmail.com>
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <CAO1Y9woENiZOokwqSeSbmr30w7ksw+ZkXUR9pU68Kmfm8X+K=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCKzennO95ZKfMmxxPnGZLXiMz0N0aAVPROVZA7B2mBp9qBTHe+RhkYYkFjwXHt9o220S5O1LEPjLQpCeIc02mPojXqvFzDiIE7ZWsgpX5ldMYtUfhcT
 MaePlC3ibqMr9Ok49A84hnPOPUg/P8lxFP02PW8YWEVo1i4TOr4RPZePrd2hpRCg/kpEIeSNwTUua9O3RBwEyDTOSZ4QtQpZV5EAdqi9xJyYv6bVpwUiQzUN
 /h08TfRQps02zyT/dXsZ+gicyr6oIGauQ7/yoQT3zIPbZLV+8l+Um9v2KxEnYqcTzDcjK+sY3GlTxgR6A/Nfqw==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/07/2022 15.52, Thiago Ramon wrote:
>> Good luck implementing that feature just for RAID56 on non-zoned devices.
> DIO definitely would be a problem this way. As you mention, a separate
> zone for high;y modified data would make things a lot easier (maybe a
> RAID1Cx zone), but that definitely would be a huge change on the way
> things are handled.


When you talk about DIO, do you mean O_DIRECT ? Because this is full reliable
even without RAID56...
See my email

"BUG: BTRFS and O_DIRECT could lead to wrong checksum and wrong data", sent 15/09/2017



-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

