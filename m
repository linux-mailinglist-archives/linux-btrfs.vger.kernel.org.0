Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5566792E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 09:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjAXISs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 03:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjAXISo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 03:18:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EBC303EE
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 00:18:41 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQeA2-1p5Qui3Boc-00NjKQ; Tue, 24
 Jan 2023 09:18:35 +0100
Message-ID: <a4fc9b9d-ae36-4cac-fa5b-84df17a023a0@gmx.com>
Date:   Tue, 24 Jan 2023 16:18:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] btrfs: separate single stripe optimization into a
 dedicate branch
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <4e4d6e0aab34ab40fd0ac69874141bb02a559f10.1674546545.git.wqu@suse.com>
 <Y8+T5PIURkONMvTD@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y8+T5PIURkONMvTD@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9A/n1NbfhWoeLW1Wv8l0IzwKERSm7BumxmlHzIsCAtwhl16ghKh
 ivdWulauR/gGZwOwv1jTBGmz20WUbTNnWyY2H2c1+jBB+991P8s0okZpCdvy8z8QSeBcBdy
 lBBaUKoqDzVHCRsvbbDscjNP/AdlylP8Lgj4/pKK0CWObY1GYWcMGyvgUgGX2ewRlFjBfSG
 gC0Y2VxCdocHjQyitdasw==
UI-OutboundReport: notjunk:1;M01:P0:Qi6jkeIai3M=;rt2tRxo+SWElAOrDK5uKyzGxXS5
 +eODziEtFvncvub6ybFag/e5ZDw0A8hU7Zmh1t2EBk3to5jCKASQz9jIxkHKEafgSNc4XXCMJ
 nd7m2Sw0iuGr+VZ3zC+ph+ufSCbL0cNfyyepz8+AOtbYAMa8VsFl4XNNGFKVPwndFhQ+E6MBM
 J2FTd0AHtenXrzgspzbBp/W+AA4BPpKUz2cbPmV4Abin8AvxAbyMfz5onl0iT/OB4QCXGqZOr
 vpKmgiZFj+I36+AbZq4RkUZ8wY9rQZBVLDtYKrt/2fYR3zFQbnUSLf1M/u4CCpIhvL/BwfnG0
 Zc711Gsn3ah58NtUzsu27nEZHh4NXxarFKFwJB5ZxvZmbOs+AVhM1dTTidIoZOcYnvgU2A81P
 0onmbEFkZmQvyEQmKx6eOooP5zHKAwvNRDXlPUmTlrkOh5KaSW4hcC+/ctug7nYpk9TdJyMfh
 fRqEEZ9vK1Z3HEySSF664PDpYOx+0TWvSET7ipoVJpfRmgXBZt0CHcUHRHSQTCBQ9yO4FOb7y
 X3msjyiy6I2CJxhGUAO/EFwgg8+/MSQdKAGHSqrxGud8hdn1PgY2xeartpqNXEYPRGs3ZuPY6
 4bUipoL5xjdCVVJhGc4XbaW92Y1FxC2yekOnVDrlozFqXrlTJQpLLbQs7ERSFadzPyBLkjhIM
 MRAQN0GJ8Qmj5xEAoK/UwUwB97km3mtHmjKAbeouuA7nqWrVscZv++tOMgeKUdgcri2Gl8sDu
 FegaTiInsjQkjprw8VJ1BYwq2iJbE5PLVCznS6OlBND3ULX/+rxj2+abla+bVgNn/BHtUdoMS
 zCoYA4rv+DQkAoeKJ+rx5khhWNzz5pYhuzP+e1CNJ4A5LbBH68SxsVHIn49Igz+x/2m1iditR
 hqeykH6OXRwbSKmN1Ifjxh3K2pdTNgcd6pVROjilpYXXeSt4TF0OYdbajbO/ERPo8EEep5ADC
 fk4f/mMGIQnuXJqk7shqbU58Tu4=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/24 16:16, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 04:00:24PM +0800, Qu Wenruo wrote:
>> This patch would looks awful by itself, as it's causing a lot of new
>> lines.
> 
> Yeah.
> 
>>
>> But firstly, a lot of the new lines are just comments.
>>
>> Secondly I hope my RAID56/non-RAID56 split can later be used to
>> refactor the slow path.
> 
> I'm not sure what exact refactor you are planning.  Right now this
> duplicates a lot of code and makes the function harder to read.
> 
> So while I agree that __btrfs_map_block could use some splitting,
> this patch as-is seems counter productive.  It might make more
> sense to look into reusable building blocks and split them into
> helpers rather than duplicating code to start out.

OK, I'll finish the full refactor and send them out in a bigger patchset.

Thanks,
Qu
