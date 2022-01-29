Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD0F4A2AFE
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jan 2022 02:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352042AbiA2BdY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 20:33:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:46353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352031AbiA2BdX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 20:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643420001;
        bh=4U8O5SdQLzPjSKEaVDSSqpqpG6aScAB4MTzKZiRsM0E=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=Hsj0LVH+W9WmrZjBJNmWcJ74thprsHD+sJnw07moe18LYCi6JjkOMxkmUoFNf31X1
         9qeJglLMsVvQmFN2edg808yClyKzQDCsqlUDiBN0IOyaWw1EvzUXd9Q41UZSVmnv5I
         GWbIhsiu6GtlNBhZwD+vcDuz6//sOn1gZFCB2IMU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.232] ([86.8.113.40]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv2xU-1mMkyn38Vs-00r06X for
 <linux-btrfs@vger.kernel.org>; Sat, 29 Jan 2022 02:33:21 +0100
Message-ID: <94244e1a-7ccd-6f68-9052-5c01876b3939@gmx.com>
Date:   Sat, 29 Jan 2022 01:33:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
Content-Language: en-GB
From:   piorunz <piorunz@gmx.com>
To:     linux-btrfs@vger.kernel.org
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
In-Reply-To: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:RVGwKas0qKNMb+7et76hw5JhauX3e0prVpGb1O8r5Dy6G7FLSMK
 7iKpEjOLH1Jlx9rWFB6ta/8JLFdUgeYI0iVbLqCH3/bnMoEtmt1pOqMo5zYrTyr2apt9lfZ
 tmw/ebGfkFO28EJh/ACekngketfn2xKxAtt0H3hgs6QWatkWyoBFHt7zOu0A6tjV6wGGMX2
 /ID4lNrihHP41uIiPTDVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uh3AV0DHBrU=:KloV1z9zbb0SrbNadICYyu
 g27pFSa6joXhFr41gE2yfrdO666Qe34Yv6EV4bQxks/7OyjmZGVgHXAWSl9GhxyQGpMx7dFFw
 8Fau7oLUpoFU2l/hvAJ9h12bUx0Rh0mAeI39Ed/EkSzG44QUdgl/h7GwVPyFtDS31jrdXWBBc
 kj0WJUHen2xBLQkqvWXA/rq7XJPz9yccUDYzUWL6msCzYczOJ0sWgIwMrXyIRkKSEouJz4Un1
 7lH7M4yiTM+NC5KfLnJwEtbU/lvdIz1GprGuULsM2DYsZAfVdwgYKM+GsH5TnxBOSbKI7D9RK
 Ttj5jNp4Ge4SihvLVQx92I+e3TarJNhbXTp5sijKkDf+I9R40UfD2SJH4tHjt1yCG2W6zXXzA
 p+IXgl5l63zg7ZgfaJTCRAaO1/hihXjYeo1CsCkRh42/iQFg1IlbDIVGz9LJjvzg3q9fNrwIu
 rD+Fw2eWDNde6qnzbRNk68/priGbYduL1HJQ9NY4dSkcV9ehCwk2hqzFDGBnXlT+O0bt3eu9z
 h9CANqZ0XX+g2PYnguazySPfXOBFJwE+Zil6hgKoiDch9Hfyh0mivEh5lsngNZNJNH95QWDFd
 1fieHwqDnrCJ0wmuuDzDffwY4loYvLhfJd05FmQcMco6nOkYYIGfa85PjUQRfIq6AD/nsI/Vd
 oe6qF5UAZwSskR232lWBx2HClsJiatVP7L998n1PCwmhIhrDP6anO1XaSmOB94HCEw/5rTPq4
 LhWxoikVZmWcrnBGjZZtvQeDO5pzWxPdpDoLDTFcyl0LQPSIjt74lWFw8uiT07K1OgNwBMuUn
 YOT+iGtMKGX+C4cccSshOmo13o8AJs6UqK8WZRYZ+GyLRoPiJ9hElWZBHCwgqrCbsXbllRxR9
 ea8UEiLU29VHCiZna/eiqTi1gLFw8nxEOeB3p/ZP1hjgdisGfZEYuPd2pUW77/x+VIP8WAcX2
 nZZ1Dg07HCBPzvTUR2X3Z3ShBi2eMva+n2WjoLpzh64JW3CTC+ehsitPsIX+hiq8/jwsSD3KS
 HVGybZ9A04dej+jJd67VE1WVEShfBfw22vGj4ln/99SkgsdQnRfTRLhooSLakqCNO/NMlpmc7
 j6PK/JcPdM+GPU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SSBoYXZlIHByb2JsZW0gd2l0aCBteSBsYXN0IHJlcGx5IHdoaWNoIGRpZG4ndCBzaG93LiBUZXN0
aW5nLg0KDQoNCg0KLS0gDQpXaXRoIGtpbmRlc3QgcmVnYXJkcywgUGlvdHIuDQoNCuKigOKjtOKg
vuKgu+KituKjpuKggA0K4qO+4qCB4qKg4qCS4qCA4qO/4qGBIERlYmlhbiAtIFRoZSB1bml2ZXJz
YWwgb3BlcmF0aW5nIHN5c3RlbQ0K4qK/4qGE4qCY4qC34qCa4qCL4qCAIGh0dHBzOi8vd3d3LmRl
Ymlhbi5vcmcvDQrioIjioLPio4TioIDioIDioIDioIANCg==
