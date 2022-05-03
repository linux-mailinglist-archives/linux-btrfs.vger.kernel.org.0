Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E9D518353
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 13:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiECLiT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 07:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECLiS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 07:38:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B131FA62
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 04:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651577684;
        bh=psRFNDc+H9J9ZEl6ls5RKreK+PJVTUcYyPiw5+eIhIU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=C+CdB3M7S2+4c5dxzFdG09asrb9rQ7gS+r61fv4/Gr10GEkzassUUHrLmMZz2YVHv
         DjdhuKC3k9wJG3IOrAl5KVKV68AwngX4rjv0DFO9f08DHLTPomPveVGyvc+LCYR0Hh
         ElH74r1yZv0zwvh0gKXTXYE4lNGoPDxDkIXMpn9w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fii-1nx6Ed1TAG-011xqg for
 <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 13:34:44 +0200
Message-ID: <0835ebe9-383d-253c-8217-8f22ca2e054f@gmx.com>
Date:   Tue, 3 May 2022 19:34:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: cannot mount btrfs root partition
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220503102001.271842da4933a043ba106d92@lucassen.org>
 <20220503083206.GI15632@savella.carfax.org.uk>
 <20220503104550.16d2465877beb89f713485c2@lucassen.org>
 <20220503090842.GJ15632@savella.carfax.org.uk>
 <20220503113427.3a192c5daf6197aa3b6c93bc@lucassen.org>
 <d018c2e9-b07c-6a2d-9819-810ce81ad24c@gmx.com>
 <20220503133045.594324090c894eba9d18b858@lucassen.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220503133045.594324090c894eba9d18b858@lucassen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MCAtSDQwKgQG/Y24ewAF2W4jWOPfMOUg25vl7le6lf0yXHaQWlf
 k7auqRs5tpnlLMJFwp3z8Q63cCd0fd34x+DeKlUXt59MfCnw70KwFKajbmZSddmnW+bZKV4
 Trt0OlWNOlX5e13S+zbORkSOuyHAQ9V5fbZqPkH1eHDfUVJFb5xPoHJYaCVUi+x8c5KJiGL
 1i+PTx0ByYTaonriPRwEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tz9gRxllS0Q=:Z3GcuYZDlv0/r6q3lsPTmP
 Lyd9ce6dNtMel7Vuh5cl6TiT+vV+2d/t6odBKWO5dmE6Z+f8dqMv6ueERfVDnst2lFG4z7uXf
 ddm+cni9bxEJrBEyFmELHB3unL2w4Fc0gJtWBpgbuHVrU6g0wa2bVcJwhqKTnzGPlrsxRPbax
 j3WBp6EPkmdo8yUd1ff1rZ9FBPcq1bAiusRais6jIC72UCHjjq+s9VCKsW8ggqWurAMgD7oLV
 2hhTrFj2VWJTYDjMk6GiQgNOF8bD+rWUryGEAddvQ1VpHTG9DdUFHujxU0Rjw+PBpgXMLey0b
 BmhGXiJ1PlpjiUOcXcIq9oHEZ+WnHFC7kKBrGWynp+J5y6d4sMmHi5idsnZkOf6MHnPbZDy9F
 LimA81Sd4EHrH1MhnR9QKvidAcRRmWBjBqwaDgUFLTFfddnxVbGsHkCpPEe2nxn+B5l8dnqOF
 LYmvisXi16tYBfnY+K6BF/HDIbCxVuRcBEfLj3xu5wktYLnRx/RhnNfe6xe+Y6wZsmgMlbu8I
 e1bJ/lSWVh6rniGcRAOcDb+whfTmhPaZaXgieIeGo25cYUnpEOziMxoah3tlptQEhGNO2WNdH
 w6lmr3FTTYU0rqjOg7ju9J5KL0d6UongW/UInbwdnU0bblW2fWmPZzKRfkiI206wY/pjUs3iu
 yHSRwQdLidgwhFtYx9IwC3IUiL9pXLDleuo2FtwRKveS9aoVt/U4YROzs5SOz4GvS6g6QDP23
 DVbQgEXNHG7CDMjgD8AUjKOpK6TBT13WLbPHj1yYGo6XIkHxXTO1kMdJ3eiEjIGzQ8hiaZ4dM
 HiBec/4VOtuQHK6EEOOySBOgvW7enwHskAo0OnCwLDE4+z0Imh1MeXjGLQ1CDqAX/fnMp5V99
 5YAphPBhEiLkcPZKa9PGQDxTdQl739q4qjow7s1bgK8QzpsfrUy4eY9hK/jfF5zfDpGVj2eOT
 vEoVg5HhsJLKb3mTYl7gaK5GjnXaEifo2+qbWVPF+Un73gdE452gRpBv+/AYepImZ3aN3sIyS
 D/EMdTkenKguEhxEsEMM2sBq8dT+SULPCN91AUmqFipjbGNSiSy9HbdsU9ni54Nw78QZNCSob
 T4/0tHnlm1qli8=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/3 19:30, richard lucassen wrote:
> On Tue, 3 May 2022 17:54:54 +0800
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>>> About the option to specify the devices explicitely, is this the
>>> right syntax to tell the kernel what to do?
>>>
>>> append=3D"root=3D/dev/sda6 rootflags=3Ddevice=3D/dev/sda6,device=3D/de=
v/sdb6"
>>
>> Since you only have two devices in the fs, you can skip the one in the
>> root=3D, just by:
>>
>> root=3D/dev/sda6 rootflags=3Ddevice=3D/dev/sdb6
>>
>> You can test with all devices forgot:
>>
>> # btrfs devices scan -u /dev/sda6
>> # btrfs devices scan -u /dev/sdb6
>> # mount /dev/sda6 -o device=3D/dev/sdb6 /mnt/btrfs
>
> Thnx Qu, but Hugo is right: to boot btrfs raid1 you need userspace on
> initramfs, and these options are for /etc/fstab, not for use at boot
> time when there is no / device available.

Oh right, forgot that without an initramfs, we have nothing, including
/dev...

>
> R.
>
