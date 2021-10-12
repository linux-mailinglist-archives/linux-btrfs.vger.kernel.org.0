Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B98D42A501
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbhJLNBs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 09:01:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:56069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236644AbhJLNBs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 09:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634043584;
        bh=rP/0mCTXimGhqNWB790DoIN8q91sy/KFE+LyZ42QCfk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=M+IpxHrernWPudmCuti9+0+ADbz5/1sGDsaQfH+6Or0R8ucAX/jsGU1ry7ncDjaKC
         6CddUJOFOfbgc4dCbVi0EtQj3LDblMdtTGlyO/PiKcDDoAGLhMdvMYaVW+yMjh922Y
         EsSmRjUdAk9cezHf7O5vIfk+ShHu4nb29IsDxi08=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxUs7-1myA102Vcv-00xsSc; Tue, 12
 Oct 2021 14:59:44 +0200
Content-Type: multipart/mixed; boundary="------------ZviG02GsNzpNz59h4BdH8RHA"
Message-ID: <3a913681-58ee-6fe0-c414-3e33deafdf1e@gmx.com>
Date:   Tue, 12 Oct 2021 20:59:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: All Three Superblocks Damaged After Kernel Panic
Content-Language: en-US
To:     K Chapman <mailbox@kchapman.de>, linux-btrfs@vger.kernel.org
References: <fa22-61644680-fb-24052640@191566126>
 <91bf1af1-494b-ee3a-01c9-07a4ad836eb7@gmx.com>
 <5d8526c2-425d-fef6-833f-2164c0bf754a@kchapman.de>
 <cc88df9b-734f-be4a-dbe2-cbd14b321fef@gmx.com>
 <8553dafa-14c5-b09f-d10f-83d995d062e0@kchapman.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8553dafa-14c5-b09f-d10f-83d995d062e0@kchapman.de>
X-Provags-ID: V03:K1:3re8wMRKNfcMSOoilg5Hnxs/N3T8+3MaGVUoidEiYs7pNVTxvDM
 5U2IULVcHsmV8wVgBcJVh4kcE+N33TQan0ZDMbAiIrvr+D8iRUuiNGpmJehSdClCpjTLldP
 +onDeYorI7nhtKtC7u63z5QYSE/AZoOyeZ8H+xDOvqxgx6IH8qlq54ygq6VqIDAVFnIu67u
 8jO54VAx4qFh805Lu1F6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eg6vzrgKxg0=:FRRTMmBXyX7cBN6rr8JqVE
 PM3mDm1B5dEDdCzC2VIfdmwai/kRvXk9dMBQZ3HUD5ViBMOviRH5p+CGMZr6uRXhRuCYSO8tk
 3Kf5L2IIw95MqFYG9gNqgaoK7DS6c6h+qqhySJoj4CCqcWPJhsXOn+bokDk9nYxKX39WA6/ml
 4ZIKl/25PKE9xha3G3AQTEHyyr7UKF9PPo4SNiyph0hPknGKb9yXJA/EFXBylp0YUrKgQJbif
 VSi6LZZbuyWkJgy/BsqQM8dF3OEdljbZ5R3jR6Mz8bEQ3oCx6eFCx3KPZSsuiEav/59jC7OoL
 Nhv9VNwC12ZANfMRrrKIlFfJDPqNaZoMrBOgc+L5OA/WKOtQaC0GswLLTLFMD8VBjw3tXqNNj
 3xX9QQ6+BkqtJ878WDOkdEok1HS6/I1hQHs+Vx8S2LkvLkep6rqdisdg9aKqbbCeXpltxxvcb
 jJo7PFvQJFliw8jnjd1L/aIX+iL+Mt7SsyPgavF3+4J9Yuwy9ILyrTArdbx3AD3vBNuy7c3aT
 KaV8ti3sIpi4lQest3k1smjuvnreqgaw0TvDE2I00d+ITw2hJFcV41+nsdjxo6puemjLOdOiB
 CwhF+wWTCmTKwU+rV/txYhvA+lT35QgzypFtUCrfsQwHj6+cs2Hd+pXC881rQHZTuUYxHBQs2
 j2q6UfFGrDTVMzN3Nr1cgvGCr/U4TJbe+nc8TLjqpiapfkPSD1KRKut14rztwYNNs1wL75e7t
 OkkvAVctxQaiLAEVldkKSTcJFB286gs/xuznxZNcejXXfglCeCCHwyOL49WHGvzwAWtmjcdak
 BSPGiJ2cSvpAR4+6RpUxZupPJ8CMIkOfHIp1UqhCmD6cvrjoeTOqPUi4qPH9H3XiIHw0SXKfa
 35KzhjcV0totqI3iKw3LMkkp+JrSu+1/T16JSRE+/IP8EUJWqDtNsJZCcxXTv0WVGilq7uIhD
 JyVC28ySobaUrsdn2MRbeesQHK96ETSgY+JbVlYX15PjVCQGhEDfas7uj0mW7KaSwEHBWPn2a
 fQdOsyeVqyzn2KbZ8Fq6JVAuO2in+E/GtefmIa3VDFO7GsraIRj3X+cilGeXMJ3UgwJVAbZIe
 64oG50n2yVlTL4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------ZviG02GsNzpNz59h4BdH8RHA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2021/10/12 18:35, K Chapman wrote:
> Qu,
>
> RE: If you don't have the tool to do it by your own, please send the 4K
> super block (dd if=3D/dev/mapper/home bs=3D1 skip=3D65536 count=3D4096
> of=3D/tmp/sb.dump) to me so I could do that for you.
>
> See attached.

Re-csumed super block is attached.

It passes my local test using btrfs-ins-dump-super.
Thus the csum should be correct.

Wish you good luck salvaging your data.

I would try mount with "-o ro,rescue=3Dall" first, if no luck then
btrfs-restore --dry-run to see what can be salvaged.

But I doubt how many can be salvaged, consider how corrupted the backup
super blocks are.

Thanks,
Qu

>
> RE: Power loss and data writes.
>
> I believe the possibility is present but remote. I have not had a panic
> on x86 in many years during general work, this is more of an indication
> of some sort of problem than simply removing power at a bad time. It
> seems more likely, that for whatever reason, the kernel wrote spurious
> data to certain sectors, it will be interesting to see.
>
> Thank you!
>
> Kyle C.

--------------ZviG02GsNzpNz59h4BdH8RHA
Content-Type: application/octet-stream; name="sb.dump"
Content-Disposition: attachment; filename="sb.dump"
Content-Transfer-Encoding: base64

yt72HAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC9WHKtj+5NkLBIuBEgzjJUAAABAAAA
AAABAAAAAAAAAF9CSFJmU19NHnUCAAAAAAAAQL7YqQMAAAAAUAEAAAAAAAAAAAAAAAAAAAAA
AAAAAABgfYGjAwAAAIAiMJwDAAAGAAAAAAAAAAEAAAAAAAAAABAAAABAAAAAQAAAABAAAIEA
AAAgXQIAAAAAAAAAAAAAAAAAAAAAAAAAAABhAQAAAAAAAAAAAQEAAQAAAAAAAAAAYH2BowMA
AAAAbcGiAwAAABAAAAAQAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAR1k8
TWidTh6jENx7irJsUb1Ycq2P7k2QsEi4ESDOMlQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAHnUCAAAAAAAedQIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAABAAAAAAAA5AAAUAEAAAAAAACAAAAAAAACAAAAAAAAAAAAAQAAAAAAIgAAAAAAAAAAAAEA
AAABAAAQAAACAAEAAQAAAAAAAAAAAFABAAAAAEdZPE1onU4eoxDce4qybFEBAAAAAAAAAAAA
0AEAAAAAR1k8TWidTh6jENx7irJsUQAAAAHzGjiyKJvHvUumx985AaJSAAAAAQAAEAAAAgAB
AAEAAAAAAAAAAABQAQAAAABHWTxNaJ1OHqMQ3HuKsmxRAQAAAAAAAAAAANABAAAAAEdZPE1o
nU4eoxDce4qybFEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAICe
2KkDAAAddQIAAAAAAAAAUAEAAAAAIF0CAAAAAAAAgJjYqQMAAB11AgAAAAAAAMCx2KkDAAAe
dQIAAAAAAADA6sGpAwAAGXUCAAAAAAAAQLTYqQMAAB51AgAAAAAAAGB9gaMDAAAAgCIwnAMA
AAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQIDAQMAAAAAAAAA
AAAAAEC+2KkDAAAedQIAAAAAAAAAUAEAAAAAIF0CAAAAAAAAwLfYqQMAAB51AgAAAAAAAEDM
2KkDAAAedQIAAAAAAADA6sGpAwAAGXUCAAAAAAAAgLjYqQMAAB51AgAAAAAAAGB9gaMDAAAA
gCIwnAMAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQIDAQMA
AAAAAAAAAAAAAAA+y6kDAAAbdQIAAAAAAAAAUAEAAAAAIF0CAAAAAAAAwDnLqQMAABt1AgAA
AAAAAEBIy6kDAAAbdQIAAAAAAADA6sGpAwAAGXUCAAAAAAAAwDrLqQMAABt1AgAAAAAAAGB9
gaMDAAAAEKkznAMAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB
AQIDAQMAAAAAAAAAAAAAAABn2KkDAAAcdQIAAAAAAAAAUAEAAAAAIF0CAAAAAAAAQLXUqQMA
ABx1AgAAAAAAAAAq0KkDAAAcdQIAAAAAAADA6sGpAwAAGXUCAAAAAAAAwLTVqQMAABx1AgAA
AAAAAGB9gaMDAAAAQCIwnAMAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAABAQIDAQMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==
--------------ZviG02GsNzpNz59h4BdH8RHA--

