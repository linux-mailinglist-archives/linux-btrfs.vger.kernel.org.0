Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A25FE61A
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJNARl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 20:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJNARg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 20:17:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D86183E37
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665706649;
        bh=Qx4P1r7gGWyOg7aIOoWK1xO9k6Oo74oBZhoZNrMgB7M=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=H0cSTVppGQA15KbPS9Ryw1kZAUPDh4ckiOkAma0u+/kZiyKoSOdqazhYDSgw4h4TH
         jwj3juG768wyiie2eSsnK8HwS2mAKbXIXSXGn9moFjchz93XjPBRttz/SESq2xB3ZQ
         +JE+U+JbOWS/BFKnA9HHPlUi+Izt9iE/ibF1Tp1s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mGB-1pCSgN2wPL-017Ee1; Fri, 14
 Oct 2022 02:17:29 +0200
Message-ID: <edd170a6-69ee-f454-8db2-b0647a4929c0@gmx.com>
Date:   Fri, 14 Oct 2022 08:17:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
 <63038e02-81fc-92b7-4e33-0a2c6c356698@oracle.com>
 <a2633456-dd2f-534c-6505-fa4c8121f3e5@gmx.com>
 <65b15910-fe1a-b6d7-2431-4badcfa0b134@oracle.com>
 <96de6625-fb23-b44b-b4ab-9aae52ab70c3@gmx.com>
 <b135361d-58ae-7bf9-fa3b-d11d5d5faaf9@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b135361d-58ae-7bf9-fa3b-d11d5d5faaf9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wr+/DItTg8c6VqM5ZG9g3C4pClNxZ4oshYVu9ksos+fUxOIRqKG
 Kxo0vi960GLG+nxEQaO1Z9LtLLKxqSUQhtYW+7dnLMb22RZUbYso/gD5adg9iX2BReYYMGH
 joGoumRLmxsv/qDduE2lIvx4eSXJNpIZ7NHbnLpdmwYPayCni/gbv308cMncN+37Gao+KJs
 TnuM7ta4QfrUzKbzJBcbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bjFPDRSU7no=:PZzJhcjfqSBzi2GruC5wwm
 gJm6IsGS8KY5WEFwpJ2ntmCd9BP7JhujfI58EBWzGP2zo7e0SoN6RjTCtkpXxkPjk19YRvKBN
 lCVcGMCbJMMLIJrhl2yuRF6Dy3TulqsYEBzahdAFjbZty+GxfuCbNCAudzGQy3B7nj62XRnyW
 VAa+/OSmieiCP9yLcdRoMeP0Vyo5BpH0kj0lX3J6/B8W+4vOpnoqYhK17/DJanA4EwSHe+HoF
 0yzVfNAwZkzWehInbBZkv9uaC3l4/30uxSiNKbt/NjD79DNMVT/EdFENt4qMNICxGTLd8dwEh
 mSoqoB7bdFz+fD83KrWJcsx2jYpKBrFD4JgJ/Yf8JFuTEDEXaiKnJLg+6TWHa4g2R6vbHe0mA
 Fs66P0pfzxhB6nXArEJ5yDQ6UghyZKRNwTDy+A0s3HL1ZbifgI6oX2sS/PwDmxSYPoLCWeYV0
 c0o/tk58HWd+cO/YsZFhQgJ1nTbwtHIS6jCOdEmcBEAVRzXPcExsJunmh2hEFMIQI+GMn7y9T
 lIBdqdxRFhPEVsZqM5bXdmY1TzJ87Y5dKXxHNGd2Xk40EQvjed+0r/rbWmQZVSx1CyODNxyhi
 FG/y0anZWpvFMa/sa6Ydcl7FoDGIipb97Slqu0uN1p3KR3C8mc4KrszwIytPMRgoxKw+GrLdr
 sSV0AGosINyk5K6iOJF/Hvw6EnptrGWytrh9yg65nv0al+1FAwNUuQ9Ecm8o4ufImxYa5MtWd
 uqrlTOa1Q1BaRf98K2w1XjHaLTGCYdsAeDKf0KCswnI+m5zyJkQ3RYD1QoNvuLiRRXoC7sqiZ
 OiT3hZPEBgRoDSjmp0nlXyX35skgf3dQqFOEFVk1gp2MFKbZMjpbGYtzHIG8qL+18mlS3RZNZ
 RUzKj8Sz8GNHL18gWkRx12lC9etNc7yklK8dRRXsd7ho+P7RcX1OKbtLmkn/IhIamOFcJNJ+k
 aDZz7oEh79MvtmKsEsomy7fmpmd/OFHCpJ5b2O7wfEzDeQrIUK/ak0eOymDZpQHeOWx04iKS+
 XyvQtIekWV2qqpx6ITgznqQrq8KSVDXu9DaH8GToJv5S4QcGlSDyjtU3vxap3+JKctOkvHI0x
 nt9Ifm2oyExQl4sHW4UFoV4iSt3Cz4i2Kp+PHOkz1Ga9UmMRH05QvtP56zKXoUWnQ0v/mVl9q
 mmO1dDGhaUYL+jZ5OKQEsTMwkH5VBML2ier9yHXiI+EhuLE+S9tnLy+8fCBWW9q6FNdypGAu1
 jzfB1Qanedj5lvKou0BJ+ADL+i4FR089umbl9xic6nnTOg3+/PQqjHkTwaMVHt1xoxAeObxhj
 iseNomQ2e907r2N8ZTQ8lnMVRUf4Sy7H9EmApL3k5588e87B2RszoxAVy/hZtYAVRdImW3KvJ
 VEW+W/vRAX+ZsJfT1JqzDc2sYJNIH+aDvMp8N0/X/0IOJ0LZ4AHfqiY+SLE6tvhwg5/gJXPUR
 Wd5HlEUJDhNVyHWOhGk/OWCVQTkw9tmtAB2aVd0xExA+s6IqZ/nF2/1kHCsmfGeJ17XTrT0Ru
 8eiWCnymi8Ex8sAaZSDJVIthRaA7LOCrJlmUGJRGTD/eV
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/14 08:10, Anand Jain wrote:
>
>>>>>> +static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
>>>>>
>>>>> =C2=A0=C2=A0Why not move bool mod_init_result into the (non-const) s=
truct
>>>>> init_sequence?
>>>
>>> Any comment on this suggestion?
>>
>> Why you want to change the init_sequence array into non-const then?
>
>  =C2=A0 We can remove an isolated array mod_init_result to contain the r=
esult.
>  =C2=A0 Instead struct init_sequence can have results as a member.

Have you ever considered that which section the array will belong to?

Have you ever considered that one can modify the array now?

>
>
>>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If we call exit_btrfs_fs() it would cau=
se section mismatch.
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * As init_btrfs_fs() belongs to .init.tex=
t, while
>>>>>> exit_btrfs_fs()
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * belongs to .exit.text.
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> =C2=A0=C2=A0Why not move it into a helper that can be called at both=
 exit and
>>>>> init?
>>>>
>>>> IIRC the last time I went the helper path, it caused section mismatch
>>>> again, as all __init/__exit functions can only call functions inside
>>>> .init/.exit.text.
>>>>
>>>> Thus the helper way won't solve it.
>>>
>>> Really? Maybe it was something else because, I see it as working.
>>> As below.
>>
>> You removed __exit, which removed the section type check.
>
>  =C2=A0Yeah. We don't need __exit return type in the helper function. It=
 does
> not make sense in the helper function.

No, you removed the __exit type from the exit function!
