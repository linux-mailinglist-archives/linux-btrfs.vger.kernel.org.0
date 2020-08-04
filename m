Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2888B23BD57
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 17:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHDPlA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 11:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgHDPk5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Aug 2020 11:40:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D6AC06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Aug 2020 08:40:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a26so17151623ejc.2
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Aug 2020 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=WzZBomgXnLT2k2JLbw0uuVNqwfAPvzfKZ/CESV282NI=;
        b=gvKjG42qiUQaVVxM7nfWbqgTWJyK/WVKFuF1BpxavB5ENHQtoOKaKze0Zs62Q1nlN6
         MW6T+LbgtYhOk2WCfvDurcCmL/MMrs4o+KlaB70fhCTHh4wecZu4N4vEv4/GyMn9VLcA
         W25XvNRU1wjG34hSja6DlFdiBNglMTOvZXGZ42FFu+tIxQSXY6LlujdkbM2+vPmpwX+p
         TauTFLlCXv4TQAyqEdVDPjnzgbMjb+Xjh3lZjTLDfHOvQ7od2qdnKDJoL9rvN6hegjj2
         61i2/H7mZpMXvL33WnF6YZNnFfVp6sydIBwQDVw3+g25k1Hx+SLtG6bmj0mDja6cO8P4
         vL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=WzZBomgXnLT2k2JLbw0uuVNqwfAPvzfKZ/CESV282NI=;
        b=LdBwvykJyiArmjrgP7yMHqUGuP2jjTkdWIrfMjqqG4DxEXFvqo2uwK6WAF0IeGd62N
         nWHdPQza8JollrbI1NeT3fqHx7R/Uq7CwhtlvEY+7zYWa0BNeiVSVt7IophP7qu00X8X
         fWKWbTrk0YZHaP7R1jYHBqq3Rj7+LdNE5V/pZ7BsUNrpOWLUzS0JCcX5BB0SdXKoLHid
         eMNxLptbAsJbe/gVcVRYbwJEkNznXObIyLmMVnkHqZJjEsVm2VqIyX9/9Qam9f+LC7A8
         NZ2G85M/AWGy2kpwQpmdbFhocgupuk01jf1cYB2fc4UJk+YP8tKG8zaTJpCSU6qp2/K/
         FjeA==
X-Gm-Message-State: AOAM531daNPa8sV52ofUPFibd34lxFe1AyA5BkoGlDxPN2eVWqTbB/n+
        MDrOyrHhqWKil5MkUV368fxstFFYYxf/gN42uiB1RIIQdNn56Kcfk+viUTuTo857zfEHyFdj2EG
        0NnLGHFLdkNTzn4gYWLUHdzBxPoA=
X-Google-Smtp-Source: ABdhPJzbcp3FITuPakHbGTlb/2I+Dv+pjXe52qy+UDv/rDnFdbmNwz/kPAMsaNqYK+705CCkPERqvA==
X-Received: by 2002:a17:906:ca8c:: with SMTP id js12mr8811737ejb.195.1596555654351;
        Tue, 04 Aug 2020 08:40:54 -0700 (PDT)
Received: from [192.168.0.142] ([62.218.42.35])
        by smtp.gmail.com with ESMTPSA id q17sm18646061ejd.20.2020.08.04.08.40.52
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 08:40:53 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Edmund Urbani <edmund.urbani@liland.com>
Subject: Unable to remove missing device from RAID-6 due to csum error
Message-ID: <febe56b5-6674-9706-1a04-ee49fb00aae5@liland.com>
Date:   Tue, 4 Aug 2020 17:40:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

so I have removed one of four disks from the filesystem, operated it in deg=
raded=20
mode for a while, and then added the replacement to the array. However when=
 I=20
attempted to remove the missing device, after several hours the operation w=
as=20
aborted with an IO error. dmesg showed a csum error. I ran scrub (took a fe=
w=20
days), which eventually aborted as well. So now I am stuck with a filesyste=
m in=20
degraded mode with a missing device:

Label: none=C2=A0 uuid: 9c3c3f8d-a601-4bd3-8871-d068dd500a15
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 5 FS bytes used 1=
5.00TiB
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 size =
9.09TiB used 8.81TiB path /dev/sda1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 size =
9.09TiB used 8.81TiB path /dev/sdb1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 size =
9.09TiB used 8.78TiB path /dev/sdd1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 size =
9.09TiB used 558.53GiB path /dev/sdc1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *** Some devices missing

sdc1 is the new device as you can probably guess from the fact that it stil=
l has=20
a lot more unused space

Help?

Kind regards,
 =C2=A0Edmund


--=20
Auch Liland ist in der Krise f=C3=BCr Sie da! #WirBleibenZuhause und liefer=
n=20
Ihnen trotzdem weiterhin hohe Qualit=C3=A4t und besten Service.=C2=A0
Unser Support=20
<mailto:support@liland.com> steht weiterhin wie gewohnt zur Verf=C3=BCgung.
Ihr=20
Team LILAND
*
*
*Liland IT GmbH*


Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
Tel: +43 463=20
220111
Tel: +49 89 458 15 940
office@Liland.com
https://Liland.com=20
<https://Liland.com>=C2=A0
 <https://twitter.com/lilandit>=C2=A0=20
<https://www.instagram.com/liland_com/>=C2=A0=20
<https://www.facebook.com/LilandIT/>

Copyright =C2=A9 2020 Liland IT GmbH=C2=A0


Diese Mail enthaelt vertrauliche und/oder rechtlich geschuetzte=C2=A0
Informationen.=C2=A0
Wenn Sie nicht der richtige Adressat sind oder diese Email=20
irrtuemlich=C2=A0erhalten haben, informieren Sie bitte sofort den Absender =
und=20
vernichten=C2=A0Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte=
=20
Weitergabe=C2=A0dieser Mail ist nicht gestattet.=C2=A0

This email may contain=20
confidential and/or privileged information.=C2=A0
If you are not the intended=20
recipient (or have received this email in=C2=A0error) please notify the sen=
der=20
immediately and destroy this email. Any=C2=A0unauthorised copying, disclosu=
re or=20
distribution of the material in this=C2=A0email is strictly forbidden.
