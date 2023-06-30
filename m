Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7D374392A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 12:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjF3KQx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jun 2023 06:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjF3KQv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jun 2023 06:16:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B1C10C
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688120206; x=1688725006; i=quwenruo.btrfs@gmx.com;
 bh=UeTOxarE7zhvNJZgOxbvcmmnGViIf2IiPhyV1zkBUA8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=jJlioCBEbzMeYxhPaKNgbqQrR4qkEEjgNgSabealbkGiagOpa9dKFlf42uV2Whuld9puVZH
 TvI3kpmUqFglMU+YXabIqfCKsfE/7awGhxhdHSpA5eUDNvWgRc9D99waQWeHKG9VI4g6hluTw
 7DnZsTsCCNQlQsnIKqGoXOmih1hv+1APZd+hYPsreRD36iQHBhvFenie2OL8572nfLp90KmDb
 Nzvjhz3fYP7l2jfygjq3ZUzk46gkj40KV28zakswVEbPWJ96Ln8RlX0lSmfSi/sLXoEIpGMED
 40Eld/gk93Pd9j+UAkFHxPMXpvJWS/SJRbOambSuX5qBqau/E2bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWigq-1qZ1OQ0m2y-00X4Wh; Fri, 30
 Jun 2023 12:16:46 +0200
Message-ID: <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
Date:   Fri, 30 Jun 2023 18:16:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: question to btrfs scrub
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:USltMSRIitYF/IVVBTVQXylvrDM3icpTVcsxt2SVzxCbTe+l5ag
 FUWkJD7jV3PDoEBhIYydDRi0P6V0Ex8Ms0nKqX4vEeSA+6qK5jYQNQRcK1Xvhfs0rYMuJh0
 CCruTttiJoed+KrGj+48b4ceOPEPtUiQ3se10V+8N9VW75DTBsa6s1e6brvThXCKG66hfhc
 I9i/zFaVn/Xp+C6rdhFUw==
UI-OutboundReport: notjunk:1;M01:P0:p2cFwvadoP4=;tJoglEtobCTGr0QD9g94SQsBSMj
 uBxHyZwwk2BkydgqudR4Yajwa6nrB5xxBa/v0fFvJZSLZlh5bg4Zcnp005olLZlQ3eVyT2Fjl
 jz2e50uO0PlAODAg+goFukqqvb5/b0e0PJZvoHLDTJl4xOLme/ZzWxTCPlP5VVrI2LDuiM9qR
 FrRbA3H9ilzCv2TfOYAhXMbe22ZMAkLdFwTSU+GSbBJdrZJkv75X4je7CycP9rrETcl7Qa1gZ
 4V92zErzZzCkpIbBmRh6yRMdcjvTzI/ZXboZ2TiyuKfgltD/moZH1juUOi20ngBADVpHQ4eY4
 xWMkVAt2t0R1ym5NVYQfQbgY268lktpEMhJuGbCdrAJRXDuttRfBABDwZuEN0Xc0QYgqrxMib
 GTGUrIriy7gDbf8EGOWRL6zQkE5L1l0yVgUaOFbhr7Y9bVCCWW/IAY/Kc46F9YRHYnEUfbogk
 jErHbjj5A/L+JuSbF5Wdwg0loa3ddlWeePpVadvc4mAaF7pD3QHZGB3YDXmb1O0p2iPw0W7xw
 8ucGQSLxH1O03NkvgXsmfsk/jTUprPudacPx/x7/wJ5BShW6tB91EjsxXFhdZrtyydfKGBlUo
 tZQx7lHNmfQVGkXvKnb0LGTT8uEqiTI94Ou+49WN+1xdsMVk/NFWMKqHcMvJ1OubAeeZBpQ5M
 zA/Ox8Ffu5jHnEw9izUBtRjh1fOR6ziSt3i6baL9TDSSidtxCSqCSkEMH5gZGKCQ9bZikKoFs
 O2u34fPL2i8UlfSZc8bpu3N+Arvz5QTolRA+9sDK49m6dCS4wx+X+CJo+Jkug937xcnoCNTCW
 0UZLKg3JPL1L/8nGIkxzjHeL28JOBN4DJGz+K5b3yPSXC4BbCeU/pm0uaFeVrfVhYdtugWbFD
 8+2s1946Rvqz/RWM4Nh5Gb1ceE0X5kTkv8PV22wu9gApD3tdFdBh6AA+KNSSxTligsTMYNPrs
 hdDa43NGCfYMv+3OecWlfS0LPhg=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/30 17:59, Bernd Lentes wrote:
>
>> -----Original Message-----
>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Sent: Thursday, June 29, 2023 11:08 AM
>> To: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>; linux-btrfs <lin=
ux-
>> btrfs@vger.kernel.org>
>> Subject: Re: question to btrfs scrub
>
>> - Kernel version
> 5.14.21-150400.24.63-default
>
>> - SMART info
> ha-idg-1:/mnt/sdc1/ha-idg-1/image # smartctl -T verypermissive -a /dev/s=
dc
> smartctl 7.2 2021-09-14 r5237 [x86_64-linux-5.14.21-150400.24.63-default=
] (SUSE RPM)
> Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.=
org
>
> Read Device Identity failed: scsi error unsupported field in scsi comman=
d
>
> =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
> Device Model:     [No Information Found]
> Serial Number:    [No Information Found]
> Firmware Version: [No Information Found]
> Device is:        Not in smartctl database [for details use: -P showall]
> ATA Version is:   [No Information Found]
> Local Time is:    Fri Jun 30 11:52:26 2023 CEST
> SMART support is: Ambiguous - ATA IDENTIFY DEVICE words 82-83 don't show=
 if SMART supported.
> SMART support is: Ambiguous - ATA IDENTIFY DEVICE words 85-87 don't show=
 if SMART is enabled.
>                    Checking to be sure by trying SMART RETURN STATUS com=
mand.
> SMART support is: Unknown - Try option -s with argument 'on' to enable i=
t.
> Read SMART Data failed: scsi error unsupported field in scsi command
>
> =3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
> SMART Status command failed: scsi error unsupported field in scsi comman=
d
> SMART overall-health self-assessment test result: UNKNOWN!
> SMART Status, Attributes and Thresholds cannot be read.
>
> Read SMART Error Log failed: scsi error unsupported field in scsi comman=
d
>
> Read SMART Self-test Log failed: scsi error unsupported field in scsi co=
mmand
>
> Selective Self-tests/Logging not supported
>
> ha-idg-1:/mnt/sdc1/ha-idg-1/image #
> ha-idg-1:/mnt/sdc1/ha-idg-1/image # smartctl -T verypermissive -s on /de=
v/sdc
> smartctl 7.2 2021-09-14 r5237 [x86_64-linux-5.14.21-150400.24.63-default=
] (SUSE RPM)
> Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.=
org
>
> Read Device Identity failed: scsi error unsupported field in scsi comman=
d
>
> SMART support is: Ambiguous - ATA IDENTIFY DEVICE words 82-83 don't show=
 if SMART supported.
> SMART support is: Ambiguous - ATA IDENTIFY DEVICE words 85-87 don't show=
 if SMART is enabled.
>                    Checking to be sure by trying SMART RETURN STATUS com=
mand.
> SMART support is: Unknown - Try option -s with argument 'on' to enable i=
t.=3D=3D=3D START OF ENABLE/DISABLE COMMANDS SECTION =3D=3D=3D
> SMART Enable failed: scsi error unsupported field in scsi command
>
> SMART not available ?

That maybe caused by whatever the controller of the USB enclosure.

>
>> - HDD model
> external USB Seagate
>
>> IIRC there used to be some bug causing csum mismatch, if it's all in on=
e file,
>> you can backup and remove the file, then set nodatacow for that file.
> bugs causing csum mismatch - Uaargh !

Your kernel is not that old AFAIK.

And I don't want to go that path unless there are enough evidence to
indicate that.

Have you figured out which file(s) are affected and what's the workload
of them?

Thanks,
Qu
> How do i set nodatacow ?
>
> Bernd
>
> Helmholtz Zentrum M=C3=BCnchen =E2=80=93 Deutsches Forschungszentrum f=
=C3=BCr Gesundheit und Umwelt (GmbH)
> Ingolst=C3=A4dter Landstra=C3=9Fe 1, D-85764 Neuherberg, https://www.hel=
mholtz-munich.de
> Gesch=C3=A4ftsf=C3=BChrung: Prof. Dr. med. Dr. h.c. Matthias Tsch=C3=B6p=
, Daniela Sommer (komm.) | Aufsichtsratsvorsitzende: MinDir=E2=80=99in Pro=
f. Dr. Veronika von Messling
> Registergericht: Amtsgericht M=C3=BCnchen HRB 6466 | USt-IdNr. DE 129521=
671
