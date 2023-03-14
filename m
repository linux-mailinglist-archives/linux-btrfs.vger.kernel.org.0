Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD0E6BA2A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 23:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCNWmd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 18:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCNWmc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 18:42:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597204FAB4
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 15:42:31 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3siG-1qbZPK2swC-00zq1T; Tue, 14
 Mar 2023 23:42:15 +0100
Message-ID: <93064052-2372-54f3-4c28-532adecbd284@gmx.com>
Date:   Wed, 15 Mar 2023 06:42:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Corruption with hibernation and other file system access.
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Phillip Susi <phill@thesusis.net>
Cc:     4censord <mail@4censord.de>, linux-btrfs@vger.kernel.org
References: <ba9fb1c9-ccbc-4b93-92f9-a8c17ffab7f6@business-insulting.de>
 <87mt4f9qrn.fsf@vps.thesusis.net> <ZBCzZH7Lq2K1jS/M@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZBCzZH7Lq2K1jS/M@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PKC9b7AwE+Sa48yJz9/DAInHqwVn9zmwZz7TIypewFMpruOyajN
 OkK6kIk7Aw50jkKILJnbfLzCLUJRMgeYZBu84p6xbK6cNk/t6CxQ37pHHbenuWtFQdd0S/B
 tyO/mSG6Y1EAXsiJCJXPyYW7UzVtxtKT06tWx4YTWJlBuKEog3ScMZMHXoOB/kZuved6cDh
 lzYIVRrYK0SBhrjxPHA0w==
UI-OutboundReport: notjunk:1;M01:P0:EqW1Cvi1zTQ=;9k9WE5Rbf+13mBDcbSRyyZATc8l
 wHeXUstkv6rZiMQQfgEyj93FX7ulNkvl6CXiTO+3X9hd+j4NdGh0+Ag6bpmJGi/bo4nLqXkW5
 SyUDeLQkQ25RTDyuhdvWf0wBaCcr/UXb2pMIJGzbABHogCiGJJ8xoZZ6buGHhfSkL63zC9V/D
 sU+dVzkUkvmNyzcCkl592c3OSw0fyg2JrRoKOLdt8W/YQfPiwvTSwly8LzRAw8ZTsU4UGvyp/
 2wdctIT4BMeFKJNfA9Xb6c3WZuridhtGh7ndYP98723RAFqV8KedZjmprcgHkDyYJjicbFRUV
 kt35lOigx4hXJqhHTiKHm/O3tlVrD7IzB8cjkEgs//RMLwAW7JSb2ly1pEi9nicrRdt+ZqQs/
 vYpMP7ZVpW4aX2M9K7GBIXf3zNJzJr5Zc9hDObC46AyuyWhAn8oQZ5Gebtv/4mB5Moq0GG75Q
 fIR/L/avIhdSbD1ow1WteUJYVDij+5QxmfFYY70bi0O63efBweb0ZFfT3qgLnGjDsgoiQzTh5
 iDz69GdTwMbDAWiX7BoGKrNljn29Z+VLhofUlNis8eCeZGun2APNZv4GUULc+tUVK7YdYRZaq
 kAmiG9CiVBHZzNt977SaQg9iDY+e+HqZMP1tFKutJ/d9okFT+k+0wVgIEdo+eUSvEg20FXkim
 zvLlVZ8L6AamdZg24H/Hn4O88hSdOfjtt5QpitE55UFvBiq0MV7w58vUKwKJadxk9DSzGuJ2w
 E0pMKGpYzp7akJE1wHohI7IjO0AZp9F87Cy4uiC9b/kdLvx5Dx5NzM9lsU3FH2e5mnmS3nVKa
 0fYDnkSh7zghaaF4okK9Ol9X/OiMM05t8ZV0af+E7RLOcEL7hb8cMYZK+Rry5b7GxdUCxstA6
 tnztSyfMOPsdVL6SSQJfnFQAfDp4erauJseJhlIAwt85Bkz76QtnfmTQlqBqttbId+tOyL68s
 Aj/Iqr9yQti2u+AmmOx9/CYXt6M=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/15 01:48, Christoph Hellwig wrote:
> On Tue, Mar 14, 2023 at 01:36:32PM -0400, Phillip Susi wrote:
>> You must never boot into a different kernel while one is hibernated, at
>> least if there is any possibility that the other one will try to mount a
>> filesystem that is mounted by the one in hibernation.  If you do, you
>> MUST NOT attempt to resume the hibernated system or there will be fire,
>> exposions, and death.
> 
> I'm not a hibernation user because it's generally been rather
> flakey, but last time I checked hibernation was doing a file system
> freeze, which implies the file system should always be consistent.

And in v6.2 kernel, we also added some extra checks on super block when 
thaw the fs.

So even the user modified the fs during hibernation, btrfs should be 
able to detect the change and rejects any writes.

So this case is pretty weird.

Thanks,
Qu
