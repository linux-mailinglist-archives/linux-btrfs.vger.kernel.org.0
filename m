Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0043E7314AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jun 2023 11:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbjFOJ4l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jun 2023 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240283AbjFOJ4j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jun 2023 05:56:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF60DF
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jun 2023 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686822995; x=1687427795; i=quwenruo.btrfs@gmx.com;
 bh=r+ln2qa2mFRijRyohXqaVF3Y8LI4aYmSD2kFsyQmK8w=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=T3vfMOM4ywrDiQykweH3liUb2RKXEiHm7lnJ/n5lLwdLKfXQNhafgNmZaKgTHFeg+5Ba8CK
 p97+QdTJuzovX6XYWu4QurGcJ74vdl3zrbLGJvcZsNdf+jA1pX4g/2/kFavEdm4gJKV6BvLnN
 ksYA2mlo9Tmlw7WeCxhmnhLQepa5xgTebrGIWzok2R5GmCvls/w4wiElcSB7VO3o6q3+juKHW
 axGf9LR15OPDQX+7j/6Ex2UVnuB8XDpHNSPGptgcgScRLSKysNjxlHjhSVcKUNyCughRYlNGa
 HBKfpJHhSDeWU0n54aSbbpD7FNzDGBKMeH6I5+7EjGma6AY6mYJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59C8-1qAqBC2oLs-0018Iu; Thu, 15
 Jun 2023 11:56:35 +0200
Message-ID: <407d5523-f91f-70e9-4df4-00f5e09935c9@gmx.com>
Date:   Thu, 15 Jun 2023 17:56:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs-progs: fix accessors for big endian systems
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <55b1841a271b69b8047f1195eeb26fb23f893f71.1686738215.git.wqu@suse.com>
 <20230615092844.GT13486@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230615092844.GT13486@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gg34DNl0cXEEVxSpSl+uuggX7WexnOSVXm6eCND85QcAb6WuxIh
 mfZjeM6GsoqlPFBD06ceIymFv7PiGgWZPwoU0u2wH74H+SHSV6sjxjwQM4kUdsu0VkskoqL
 PE3+OJv11d1wpafsZ4W+Wq/oCd1bwn/uosmmoRuCGtI26nYoMnldSO9hlNqE21O6H4WtUuI
 YqN3Eqad3Wa2TavGTIU8Q==
UI-OutboundReport: notjunk:1;M01:P0:0B+v4L+r8ZA=;F3TSr37lMn5ITyeX2jFWDEriRlU
 f5U5QnE9in/hXbxjUXGSsnDROFkIgsb9EF/Dzf9VJR0K3+f5ySuWUelHI/OZ3Jbeg5Aiwqsaj
 tztujQ8MOtgC9erR1trn4DAgNUAhjB3ce+TOIApyB42h60cB2LUTZYy3v/WpEwxqOORHPSAxI
 oa89n3J7h+WaopdwcIdtGJjlTrf/20WaqiylUGRWu4k3J90D8wZIMSksqmmN4TXutM9+qd0zQ
 v2IMR1r1MfduHD4vt5/fgWMPai5E1kuUYyolN9ogoUsylbdfyWt0syn0IkPLpebGDpq7ewkby
 63synC7oCLC1uO4bETIv52js0wnJAOOCpaOqzX9K6rVD8oWYBPd4pMkWYBpK30fHjZJ8ZXiv6
 9xGPeK+2J5AJI7FBLZbOiXD9Oi5J7fui3f2if0RaXarD+8qH6IlTXF1W5yZJImv8knlgk+6AU
 fevOkuc8prXhMU/c/SR3QlMvR2G816hFB08uXM/jdUT23CVt6Q652qkmlFCet293jlCTY+2T8
 bFCfP1cDzT47fJdHCUXbuGQDNWv/gm+8SDPuEKxOUghcozzdddpjvy3D/N/bdiHiCPk7q4IQA
 BjdowJj8SIrfWezRoO1x8lpzner/m/2gUw1rKqt+P8FnndLIvnUAFN4f+r5UgVZd7+IZdFyXo
 30a+6JODkKirquEA3prNZOZS92aHqE1j9juL0baEI4PukcNosx4ZwQX1MBLJUuc6t8cUNuP85
 3cN3mL2vkKtrcXPNhfdLxXVNs36pJfuQFGXPo7YuqwvZO79WTxYJc+eK19PJJiMWJ+m8KEHhY
 0wXEnTUT7zGrOoDWoruGHfCo7+sZw2tg/ocv2MFeVV5qEtlkHjs74T4k+CsRQA8A0DUbX8C6b
 K40wr5jBY/72HWpN02I6ItdVw6NQ+GGb/YPQX/93TjMimTIFvEgWFMvDHh0KqkPfwSiikdGVc
 wyjeI6R3Q2/NWl/B48PRsWkqtkI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/15 17:28, David Sterba wrote:
> On Wed, Jun 14, 2023 at 06:23:43PM +0800, Qu Wenruo wrote:
>> --- a/kernel-shared/accessors.h
>> +++ b/kernel-shared/accessors.h
>> @@ -7,6 +7,8 @@
>>   #define _static_assert(expr)   _Static_assert(expr, #expr)
>>   #endif
>>
>> +#include <bits/endian.h>
>
> Files from bits/ should not be included directly and it's
> glibc-specific, also breaks build on musl. Fixed.

Weird, as for those things which should not be included, normally they
have something like this from endianness.h:

#ifndef _BITS_ENDIAN_H
# error "Never use XXXXX directly; include <whatever.h> instead."
#endif

Another concern removing this line is, we're relying on the final .c
file to include needed headers.
For this particular case it's not a problem at all as standard library
headers would be included anyway.

But I'm still not sure what should be the proper way to go.

>
> I'm going to enable quick build tests for pull request, right now the
> tests are ran once I push devel which usually happens after I reply with
> the 'applied' mail. The test results can be found at
> https://github.com/kdave/btrfs-progs/actions .

That would be very appreciated.

However this is better with github pull hooks, I'm not sure if this
means it's better to use github pull as the primary method, and just
keep the emails as backup methods for old school guys like me.

Thanks,
Qu
