Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07805397BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 22:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbiEaUFl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 16:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiEaUFk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 16:05:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41B93EB9B
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654027537;
        bh=Y30Vdm6r/+QcON/9yzfRzHA9ZV6+OXxplOULszBqlwg=;
        h=X-UI-Sender-Class:Date:From:Subject:References:Reply-To:To:
         In-Reply-To;
        b=J5ua6hDT07A1XkY1ETaplsKUas2OTM3wky/yhzXI/vnV50kvDOIGW5DZpR7XPF7vZ
         r3KaG/QwjgSg1P38F6oV9cb252tlKLkhK3GdiHRr38woBBuMgRBQeGbOns7skggD6o
         j7mrbS373DH1nHWQ6cHV3REic1QIGERGZhPSFAtU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.0.0.100] ([217.227.44.38]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHMP-1nYJlg0kvZ-00kcCk for
 <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 22:05:37 +0200
Message-ID: <ef628909-83e6-39a3-6297-72b07b0f6d24@gmx.de>
Date:   Tue, 31 May 2022 22:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   =?UTF-8?Q?Lucas_R=c3=bcckert?= <lucas.rueckert@gmx.de>
Subject: Re: [HELP] open_ctree failed when mounting RAID1
References: <7dd23222-1f85-2313-b708-fe00b1349799@gmx.de>
Content-Language: en-US
Reply-To: =?UTF-8?Q?Lucas_R=c3=bcckert?= <lucas.rueckert@gmx.de>
To:     linux-btrfs@vger.kernel.org
In-Reply-To: <7dd23222-1f85-2313-b708-fe00b1349799@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NTULZ8N+h2xTonvPFj7Y1FYn8z7jfNKE2Uk3r0yIbrYxOQQBrwz
 EzHOtD96e2R9h/9pvauy4+ImQ/EgHzUF6KMOc0SBE2ErMdWfttHL908mnvon4Tw0mpZHiFq
 /nKQNgujGidRQxPQN+RwzTdt45rkraPoqBpENe6ADmy3HbKnuqEyVshxIPOk/cr3aX0Zx/M
 VRM1UYKRMMAZQQ1DSQPEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lm4gn6r83hQ=:dh/sejlAyRNdtuS4m3jOqA
 pEJEU0p8IfjnGslyAy4CL/ZG6eicG4L39EgW9ddGSlEwQxByo5uV5gpVnEWA4Hd84mnZ+ojc/
 RIj05nZf0HNjABK9Aau5q/e3Cx/IJEfjOVZJ0i+PGyFm2wVENJGci8m7q89Pz0tC1lwqE93dH
 LR4fa5vyqAuk0fct03KjlW1gizpvrNkXTiS50bUQpoop2Lc9jEfLXnjViMD7K/jsOj8llWIl+
 JsgLns0UiuSWn/9xoNyZw2Zu4OclHAdtabxMNle4D4rn47OImjg47tolohG6KkAJfH51GP0f0
 lSI/9IigQDIl3gjW1RXLYXN3k23NsuLJKAsZPE0YE1Bms0fU5njiSnmkf8RVX2ZA8Yo+Dkvcw
 JMgujASENG0uuwqRhfF4g6ru4qEUDcF1OKMIgwxsRrSi5kLBzoeaK8OLg2FX4eABcJv6Jyamx
 F4oeiJNvK1ym49BUskJXoEPmiJC0D83UDIX80bDnqirfR/6FZAPpaf0OtAFNDc6WYp1kmK0VE
 A3XnXqrWkqyc+KEHJ1AE7QsMBwOGCm0igPnkjE+c4WL7yaSqDpKdusGzfAslvGyEFwALdRbOG
 pIyHlqOvFUzOQVE9jCJjSPT0wn2TByCbSLN/r7EtT5hIIV2Voqu81ZeOOLIUNqGHnAglGHyCL
 BxtNK5Rm1vOfEGZeIBu9vXMBxI4c37lNZjoL2XflTzoPKU4EiVuqaAHKKUHNWS/+dlPEYUEmm
 HBhDM1w8ImX+xYa8SXn/pLGkXbItXyGYKfH/QaxdEZzHBcbpSdvJ4hvvla0iI5gZZnQeOikGb
 wAQRy1vSk0xqMmIGbHprYoVhFqpaVbGYORTMfMX3dyW+WPdt5LF2xqCDzHL6hr7EdTt8sJCe2
 nVjkgMXBN3wJbA46etkfShA+C5wATYZ4K+Y5U2+9L9zHfXHU2zqXi8WpubfihVSTjQmXK0uzk
 LkwZTnOp8KCwnrKMtZvh7zbD0ZpT72UVfrKFpqzQfIxog/NjLyKKPU8KgFNd89cInKZ0pA2+f
 /eYYGfI/wUTQ5dxtRcNFOu88xIMmNA07KIwO2tf5+/yTL8ofiqeK3ep2k7hXS91Tx0h9yWNM+
 unDXcJ19MEjR8Fv8mqHMQEQy7ghMq6ge4FNAlW5sNGI+Ide0pMWvMsx0g==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




On 31.05.22 9:59 PM, Roman Mamedov wrote:
> On Tue, 31 May 2022 21:50:52 +0200
> Lucas R=C3=BCckert <lucas.rueckert@gmx.de> wrote:
>
>> and dmesg reports:
>>
>> BTRFS error (device sdb): open_ctree failed
>
> This in itself is a generic error which doesn't give reasons or details.
>
> dmesg should have reported more than that, could you post all messages t=
hat
> happened right after after the "mount" command?
>

This is the problem the only thing in dmesg after mount -a is:
[ 7592.168838] BTRFS error (device sdb): open_ctree failed
