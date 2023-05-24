Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC971010D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 00:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbjEXWhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 18:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbjEXWhp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 18:37:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DED19D
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 15:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684967841; i=quwenruo.btrfs@gmx.com;
        bh=AFEmoYZFWIzhasIFMy0BdIea835MuJZO2E/pFzBuX3M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ay7hfeloIEeUmiS9OXlexoJK8P3EarjVC0FzoqqCC5NcGpewFOXibox6dcwc7jav6
         yOnQoHOflbv72ZUc64NByaaVmQtNvfSxVUS211n/NfaKSKwNzmkhrbsDB0LKYLHbvw
         bVTDgDewwaPVmzn2n5zW6hbKOyCH8CJDDT39ag8VpeR4ZtU0VOkFRfz87y1rW/D8Uq
         dZMUjJHqhhn4aUfVaXclWCwiI7/OnwY8gcD/DeT+/HnsM1Bt99NLQPIVDl0jYFjyk0
         cKVFYzbYcCPmBHjQ1fuDxtTbbsQkVY61rZoCm0TFPwV/i0dYnwh+0mi0pmw88f2T+7
         S2NBjlKqlQbTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKKUv-1pgpYP0J4B-00LmFq; Thu, 25
 May 2023 00:24:46 +0200
Message-ID: <dc5d31a0-0f44-9c86-7b83-dd03f4ef4c04@gmx.com>
Date:   Thu, 25 May 2023 06:24:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/7] btrfs-progs: tune: add resume support for csum
 conversion
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1684913599.git.wqu@suse.com>
 <20230524155502.GA30909@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230524155502.GA30909@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bj5k2zYmcvRKAXiPSGjSjDebuInvN3T0YxmiS3J2T/V7y6Sjh+W
 wZgv12vFoD8fDmZVXbRTbnLA3Nlke9LsnEd7CS0hJzldJGc0Zl+kkYgLtGemoDXlmBbZ8DC
 qG/kSuQt1Eo4jo51L23s3hYb739ldtpZNZNGOhQP+slJ8ujDRHSNlGoWp4p3RkiPviRuobV
 DuGX4UNjlCF0iXOF0Hlug==
UI-OutboundReport: notjunk:1;M01:P0:Yt1cugdyPaM=;TUiE03f9ZnoXw0uzgnULdwVLnbc
 iPth2iZJ6k0YSJyN4XAg5/WaV/PjM6ENR7qMv531e9uZqFNLfg/zvJfttAxBaMsx4ZhGqDvvH
 NKGNqqWXVYTH409RGRqSI6YWRGPg4g4vKz2ndtEJ5bLHLsjwzkBkBaYDgzAfVPANdLfjO9h0T
 hyo/6WmLFvLAhKfXt3+j0I2vtTIEHl0OXeTMI/YKcV14dd6JVJnF43onOem+gfyUix3g0Ri1x
 KPxtkQRPlqVmUO2R6WRrLH++j8UaItN/gJDheYhkpBs5TF6OTjwMdEvQnixttTvMRS0PB0fyQ
 NA5cFDBGMPwHthg/XShuUR8xb0rxAF3Mh1fhZ+bIwMjkZx1KgpmC5bB2aubbDFR+3q78ASyoA
 D7RVdc5DketT9unSG80xlzwsfARuH4RsmxBH6XwCcCEew+4AyuglPslpj2IRNaICbTsAPcnh7
 3QzJjJHWxtBDlLnLo1slPl8n7GFeN9N1BiTo9lFShDzsp+30EHdwtajREp7zQEKKHOld92YKW
 BgQZcGU21sQnf72qo4Obwlq3+veX20bgAp9Um3MNplRCKhIftB/8ybikJ0WmEwCMkSyb+KuHO
 GD6ByjcAclc4gCwaMfJGqBKsEZqjNMScCDOcELmWNnYs/vnWQ7KRDBnzGBmzYKAkq+5T2oA6V
 GBNFpQ9h0qDQSl4Ktc1WYpdeuS9uIPCLjp4KX2h0vtr8awtyUCzW+H1xE3JFiUjV8ZeSt2q9P
 QYD//q1c1rMpn8CKwdkzZJzmDc0iHWSsaavAwCi+nrsB2pQWUxUtQ26QTDgJTMY5z68g6pguA
 OxEde/0FXBQkS4RW5cj22SQhbu7jfy3se35n8aC270fVKhZR6kfr1fiBbClfP5u+tvlsQB3ZH
 XiVr+CeXU8yqu9+OHkkOp0sO31lAytCtEIM9UHT/EHCGLCAuvLrlnLuoc6HME4KCR/dRTtD5T
 GBGPMKSG6dtHwRZ8mCp4T01G5gM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/24 23:55, David Sterba wrote:
> On Wed, May 24, 2023 at 03:41:23PM +0800, Qu Wenruo wrote:
>> [RESUME SUPPORT]
>> This patchset adds the resume support for "btrfstune --csum".
>
> Great, thanks.
>
>> The main part is in resume for data csum change, as we have 4 different
>> status during data csum conversion.
>>
>> Thankfully for data csum conversion, everything is protected by
>> metadata COW and we can detect the current status by the existence of
>> both old and new csum items, and their coverage.
>>
>> For resume of metadata conversion, there is nothing we can really do bu=
t
>> go through all the tree blocks and verify them against both new and old
>> csum type.
>>
>> [TESTING]
>> For the tests, currently errors are injected after every possible
>> transaction commit, and then resume from that interrupted status.
>> So far the patchset passes all above tests.
>
> So you've inserted some "if/return EINVAL", right?

Yes for my local tests.

>
>> But I'm not sure what's the better way to craft the test case.
>>
>> Should we go log-writes? Or use pre-built images?
>
> Log writes maybe, the device mapper targets are already used in the test
> suite. You could use your testing injection code to generate them.

Log writes allows us to resume at each FUA/FLUSH, thus doesn't need the
error injection part.

It has the best coverage for data csum part, but not for metadata
rewrites, as it doesn't generate any FUA/FLUSH.

>
> But it's clear that we could generate them only once, or we'd have to
> store the image generators (possible).

Pre-built images are much better and controllable for us to test
metadata resume and other corner cases, but less coverage overall.

>
> Alternatively, can we create some error injection framework? In the
> simplest form, define injection points in the code watching for some
> conndition and trigger them from outside eg. set by an environment
> variable. Maybe there's something better.

For injection framework, we at least need some way to trigger them by
some possibility.
Which can already be a little too complex.

>
>> [TODO]
>> - Test cases for resume
>>
>> - Support for revert if errors are found
>>    If we hit data csum mismatch and can not repair from any copy, then
>>    we should revert back to the old csum.
>>
>> - Support for pre-cautious metadata check
>>    We'd better read and very metadata before rewriting them.
>
> Read and verify? Agreed.

It's already read-and-verify during metadata rewrites, the pre-cautious
part is reading the whole metadata, before doing metadata rewrites.

But the best practice is "btrfs check --readonly" before calling
"btrfstune --csum".

Thanks,
Qu


>
>> - Performance tuning
>>    We want to take a balance between too frequent commit transaction
>>    and too large transaction.
>>    This is especially true for data csum objectid change and maybe
>>    old data csum deletion.
>>
>> - UI enhancement
>>    A btrfs-convert like UI would be better.
>
> Yeah it's growing beyond what one simple option can handle. The separate
> command group for btrfstune is in the work, so far still on the code
> level, the subcommands are roughly matching the conversion features but
> not yet finalized.
