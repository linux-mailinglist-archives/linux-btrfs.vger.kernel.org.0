Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F6F725200
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 04:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbjFGCM4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 22:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbjFGCMl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 22:12:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C2B1732
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 19:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686103956; x=1686708756; i=quwenruo.btrfs@gmx.com;
 bh=5QxW/WmxdOQ2zn5X55vtEl4hEx3cijoF/3WeQ0IZ170=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=chlyjiOfHclsr/Kko6ZmX5R4UJSk8IuQ3B9GBIIGSYqDATwuaw7QxcWLrsoAg6gHLrliTW7
 +sYrFvll7NoDiEIp+lVcx5fk+MNvc4RhUE9CJaLAyA2U/M9jEXT0236wP9j3P8MoMqDwnF6uj
 RG8S46ddA/G9RjA3WgY44HcgrK4Vc1fNGGwYNA2fy/dWOO9pTZ1j+lBHopUxVCgBb/J94IF6q
 IToW4OQVSno3AC7CK4+DhcQz4tgS3oD63blflEagWUtVYVS4pYdge4gif1QBxkJW6x6l+kj4L
 C9+IPxb/sq5/ll7dxj501qnjUapv52JT4BFSnIsSS/Ln8DDJzhYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0JM-1qUkot3vFw-00kLZe; Wed, 07
 Jun 2023 04:12:36 +0200
Message-ID: <543d7cf5-96c1-a947-6106-250527b4b830@gmx.com>
Date:   Wed, 7 Jun 2023 10:12:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: How to find/reclaim missing space in volume
Content-Language: en-US
To:     Roman Mamedov <rm@romanrm.net>, Marc MERLIN <marc@merlins.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20230605162636.GE105809@merlins.org>
 <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
 <20230606014636.GG105809@merlins.org>
 <295ce1bb-bcd7-ebdf-96b2-230cfeff5871@gmail.com>
 <20230606164139.GK105809@merlins.org> <20230606232558.00583826@nvm>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230606232558.00583826@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B0bE+/d4qfSOZBl7lqG8x60yoDqoYdvmA8RSYEBLrTT4vmPKcd6
 G0mj+SN3bDpWNp3dOjoPtQ9NHHPC9S42TASP2Diz78stJWnNEto6Yg1BlZZ1vY6j9O/OPor
 Z3XW2sEojM/zX4k8JtKtK9TyKN0JIA9ksq5jFLtMNvfz4W6U6wI9V9k0wKAqdyWtM/esDGd
 l7pBjwlIbl4ld1np2WO6A==
UI-OutboundReport: notjunk:1;M01:P0:TdxnQHaWhuo=;gmYHSsQRxEAMhbDfGrTghL+dAOy
 tS6aqG9MUOqfGukwQhbm7BRAQ1D4CVkL+sOQ4lAHl39eOL8ZwwqOYRRKW/UnXj887x77mnbaE
 KpWIW5YROICCrhnI7L9EB3s+Do5qW8FMPpVqrRf8rTvNT2a661k4Rem0g+WlIdDn14tHR8oTk
 QhGwuxMHrSMXfVwwKLw2Y2yMZQuEF6pJ6ZZMhI3YHNU5F/YGzKNsjOdZFziRLOg/zgG/p2+g/
 krR4sSWn+8Q1AutZCX0t4KbJATMPSFcCTFdFBeaqSk7izX+JzWUo6XSLeGIMMNNxdm+okwCMu
 Mp1RxGe7BAM/EOSgxAY7q0DOLvuJJsioRpiKT9lKNZSzfCDqtEwpY5mKGg4TgN6vWxfD40wre
 ukRD9NDPiFCusqO6+EOkV/Z7ENafGDESoDQhpY5HoSGixLw496ssxuyu1I3wK14RQwK0TrMr+
 X+7AXV70Wg4YFQ3Myl9XqXFLb2w39eUz1532NA8GPE/sLoEnSXPxnXcScidOzP9Ve3oytyuBJ
 EqTrgxyZW6sxuiauN+UruTJ06b7Difk9BtnDP3dqCWTH7/7IYuBRQNiZcdCTO45RPG0nq/dcT
 WkPXCXXuvHdCwH1kR9m60luAUdkqywTgDuo1G2Xy7ENtyqWk4rdjDFaFiCk36SPi++ZschTbh
 MU6oWprslImyjN9Rgvimd5RoZFlNl69AfrL/eLB4vBrvOsONnvpAaFLyC05X6Po4kov+KPSA+
 EuUfxZSltx93UjMF7gLClqNJ781TP58pR6UOlqWQ5D95G7k6Rnr/uXrwkbA3UXB21yBC9du1V
 G5i8OwptlawWAlt8vy99/zeg+f8sZFOZGrbpFaokAlkR3aHcU5IRhsubRJWN7K3qgxuNfXEZz
 unvsv7RnUxrbP1i4HmIe0VCvVAWxacO5tfMbLAWNL6K7iINt5BWljSNEPfE/FTeqOasgbVdqr
 cdMITCIhAmhusryDVjESPF4kuF0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/7 02:25, Roman Mamedov wrote:
> On Tue, 6 Jun 2023 09:41:39 -0700
> Marc MERLIN <marc@merlins.org> wrote:
>
>> This sounds like it could be the same, thanks.
>>
>> I started with
>> sauron:/mnt/btrfs_pool2# btrfs subvolume sync `pwd`
>>
>> Unfortunately it's been stuck overnight.
>
> So it does not look the same after all.
>
> Do you see a lot of IO to the device (iostat, iotop)? Is it a fast/slow =
one?
>
> Anything in dmesg?
>

For the ghost subvolumes, it can be confirmed with "btrfs ins dump-tree
-t root", then looking for ROOT_ITEMs with "refs 0".

I'm not sure if it is the case.

Another possible cause is extent bookends, this needs something like
btrfs quota to confirm, and not much we can do if there are snapshots.
(If no snapshots, it's possible to defrag and free up such bookend extents=
).

Thanks,
Qu
