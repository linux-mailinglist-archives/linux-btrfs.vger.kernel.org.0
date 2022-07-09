Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50E56C5F6
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 04:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiGICSK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 22:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiGICSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 22:18:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0394A6D9C2
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 19:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657333086;
        bh=YclMBChHsGhZhykJNr/tUN4uJ3Bqk81SWpptJ+EERRo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=aWKjKdxPO2nq6nimcnZ6X+wx8Lv5WmGOghb1HiSIhS8lzqB9LIgBeWvhP1MHsq5aj
         e0vcV5MYlBuD78eFWbko/+dn0CwiL+UGHKpz3szjOU+Jyv5OvJd8VigV46X0LxPLrV
         0tZoayFgoS6fjPKHvJ6W+SAO82rXRm2tNQMttYqI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4JmN-1oAH1g3XN3-000NAG; Sat, 09
 Jul 2022 04:18:06 +0200
Message-ID: <18274afe-32ac-6014-c64a-ea041e61d927@gmx.com>
Date:   Sat, 9 Jul 2022 10:18:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: BTRFS critical (device md126): corrupt node: root=1
 block=13404298215424 slot=307, unaligned pointer, have 12567101254720864896
 should be aligned to 4096
Content-Language: en-US
To:     Denis Roy <denisjroy@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6a3407a3-2f24-c959-a00c-ec183ca466ed@gmail.com>
 <3ed7ee56-24fe-4fe6-b9ec-857adc8924cf@gmx.com>
 <3b281d71-ad13-2145-fe77-e70051e0faca@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3b281d71-ad13-2145-fe77-e70051e0faca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gQqVfsKywQmL1N0aBRDeHf8DXrIuyYwOlEYShsIAHbQgZiM+MVs
 3Lm4FIatzMSG5UnHNXFvyEZzep2TgGjKjM+IXSYeFszulMbWJcJYajceCBHLtWMxS+v9mdT
 +iSQbbTxpiMpvDCq7F9Kmky3GyqBxfG5SWMxUpJG9ZaVTG8fktHGR+xydyBnZze3CzHeEtn
 h1CM4IwJg8XMonhHp/sLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3DBty0gClLM=:4uvMUaVtQSqlP4RNbnXmcm
 e3UMFLLDZ9QStW3WIeR4WMcJisdATGM2jmqUaNCvRREOE83TCwUNAAGEMQBbdj3WEZ+CDp33Y
 ddW4/qNwDgwTxt5q4MNRWSxRnWADq0FTUZw3N5YoqoRRlI4+e/lK2IVlWcZTOqIuzOLf4EfZE
 dR1d6m1RYcoCgKQTxSuqEEzuRUBt+dZaXkXbwjQnidq0amr/kczDtptDbFIo+pQqx9vH7scfc
 mbb0WaIEc99cA6wkv8UpWLzp6IlFOGMxyHZ/fFQg00W5a98P3F9waukiyvvyqSJKcduHIzHEj
 HsjbxTtAc+4ywy06m+p75lWIlscTdcZDCuadc6+sVXoQuzMXkoOIrHIPnBFG5xMD+8ZuFVAlP
 QTEplRoDFecsAusyWXaQ63t9gV0GtWBWummQgPKxzLMNB1wXTCfieS5HJGS+SlhMTpxaadyXn
 Smvr2eJ5/cEP2sRvUw5IskXD5C2l+FhJZN/AKX/Kj7oMS6keFZ6E0LezsOtJTPZ03Op89k4E6
 BEBHBtYSRDCF5ty92Gt1HQw3JJCfxhOSO0aoG8UPMV+ktWOYzpmE8UzxtMi8zW/4vVrFmAPzo
 avd0+BWA0PfrO7ZvdkD7MdpOle17Fj3NSxM000fms/tnepO8jlvNdQhQ46oTp/iY2/V1wNTJx
 K6mkceiAsSAHmfEc+ku342t03jAV6Y6H4ih2r9DCrdVuB9oL9QuMcDjp2aBYTMwJjwYwVDMPF
 t5de8Ot1VJSqaGU4D8b92F2CSkn9Vp1hhizjraQhDe976ngcwHqe/Dt+e+8G2A1v6h3AOvTO1
 RUeimPP890OAJ/OKQIZX/VCH3Hx/TtvQdJj9RqM8G5vZLdZrgrJiGlmEHJBu/Q8oyiYOFPtxT
 wUwRybhIpRZVTREzTQUFSp4N1j5KUFK528/YExwZykZ9q1RVLvgMf/d7rm9wyk1VEEV/3bwN4
 IcE6pX0DOW0GhuYWTyaXyXnxBIYtPCXOWCvLWg6qi0ioxa0st/ouyEXKymP2svjEj7Lk+ig5d
 2xtCpetAHTzReQIWBAJmG5SDoeYa4qqrNkrviNjBT0GxXZr24eyivwHTwmUHkrh6gSyiyL9hr
 rB2ANJ32Zky36IYReaoe+kI3alBdIWpZvEefFomA9elvfHthtI0Zwr3FA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/9 10:16, Denis Roy wrote:
> so, what option should I use?
>
>
>  =C2=A0btrfs check [options] /dev/md126??

No option needed. That would be good enough.

Or you may try "btrfs check --mode=3Dlowmem" to provide a better readable
output, but much slower.

Thanks
Qu
>
>
>
> On 2022-07-06 10:19 p.m., Qu Wenruo wrote:
>
