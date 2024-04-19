Return-Path: <linux-btrfs+bounces-4430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39EA8AAF2B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 15:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76FD1C215C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A2F127B75;
	Fri, 19 Apr 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr47z6YU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FDC86642
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532687; cv=none; b=YO+9oJMLxceHylaKuYyk7yQA/oIuxSpWM+j9X1VpEqRTLjPK5rpgeB6kVJgj+k988yIIuXoHiPCNbdN+J0Vn+vLjT0dEb9Dn4tvg/wkJg/zckd5cZRcCbtYCxbCWjyA6Rb9+t9twhD1EPxqXx6XSzOQll1jg83NKYAJ77p8jHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532687; c=relaxed/simple;
	bh=Lhxo2e5NK3JzgGN9m2qVslBZUXBgQzK6iHVWm0zkFNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwWuIz6jul4g4EfZqkeqDaYru3IlhNUTCK0H48xZfoc5nNuw/hbKaZ6YTKoXyuERIAFsSli6hpTYJjBxXX+/u2RYdJmrho0pZWNtEk7J474FbK/7QTMExZJ16E/CXGOqmzXD/ick9w8j7yGYXliDqIqb9DesLlbtNvzb/vOe1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr47z6YU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db13ca0363so32978351fa.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713532683; x=1714137483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpnJnxUDz/0rj32wtVJNrnq+rBRHmRmsl8u2t4Hucoc=;
        b=cr47z6YUmeNNClK+4pKwtiu2O8J6xp/wS3M7CKeqO5LsjMYuCKBm62LTb1LQWIvgdc
         641FKk42+P2kaWljrLLydBL8HT/AQI6zK1wpVqvro/q369t261G5nykiziidde73owVt
         XCQjdEyJH0GiShKmkFPfafIEaQ/kTmKMTVYAE8D5AY+eF8u3qtZYTnNynLJh0XyVuqlr
         T4UzB6Nd9E1oSdVYyu7z78LamDnVwhiLCOYTdQMvF7KiyvD9t+TlnqQOakxkqhpd65X+
         IM0ixnCn2GQUi0DWebTqdb1EUZRCNDpnsimtxp1JYrBZna320Ei0rO5OGB4s+zN+NDOU
         TCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713532683; x=1714137483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpnJnxUDz/0rj32wtVJNrnq+rBRHmRmsl8u2t4Hucoc=;
        b=fbpJMaboX/5RZxzjxCx3+43E9rVWD9iBBXPCXdFmbtE+LNskXD/PzxtLqM99d6JFzE
         RzA8NKBekGNZZCLyTdBxRrsxpc/g5BZ0pDaZYRjJ3tueWLqS2QhZky4Dl9XVXiRO1+u5
         +rv/o8I6+CZbN+byDyUutjlJqR9w6HYnR23cPpoxAbUHBV1pKY460z38EOikg+1xCy7U
         6GOvAkIgHXjPftUS1wMZAt7eeRz9xvu6AddDkqauWIrnuvlS3D7wx2bclJ4C7vgQZHgL
         AVhviYeOLg0IlGDzRvN7AsrD3bV2wvPlJ/Cl2Vcq9E7g6oonP8U/buE/tBB/q4/xZ/gN
         mhhQ==
X-Gm-Message-State: AOJu0YyCsbM23cot4u2Kv9rHk4PpU3VducMYC99AXKfe9qJbw8mqirT2
	In+s1TxNKs89Xh3iwSJmH2nRvtakQShVHSViG8IUUAq+l6lYzo21yiAZ50ejB78=
X-Google-Smtp-Source: AGHT+IHqrxi6IRPECFpPVOr2aO9/NPeJm5ZBjZq8G/BlAmv38N5VDnCAS4bI/bOzXkopMPp0ZWtrgA==
X-Received: by 2002:a05:651c:1046:b0:2d8:6ca7:2165 with SMTP id x6-20020a05651c104600b002d86ca72165mr1723853ljm.46.1713532683232;
        Fri, 19 Apr 2024 06:18:03 -0700 (PDT)
Received: from [192.168.5.235] ([109.195.103.195])
        by smtp.gmail.com with ESMTPSA id z7-20020a05651c11c700b002d80a2da6d2sm622526ljo.129.2024.04.19.06.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 06:18:02 -0700 (PDT)
Message-ID: <0d65236f-184c-48fe-8789-32c41732eae7@gmail.com>
Date: Fri, 19 Apr 2024 18:18:01 +0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: support request: btrfs df reports drive is out of space, cannot
 find what occupies it
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <b996820e-efa5-4fb5-ba4e-57cc295c1b64@gmail.com>
 <CAA91j0VmxAE=XmCPJwT9m6YXKJzDKtP-+vpcTXbp=_=fROyqnA@mail.gmail.com>
Content-Language: en-GB
From: Skirnir Torvaldsson <skirnir.torvaldsson@gmail.com>
In-Reply-To: <CAA91j0VmxAE=XmCPJwT9m6YXKJzDKtP-+vpcTXbp=_=fROyqnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

With all due respect, 38G is a grand total, so it is 38G out of 78G 
reported data.
There is one thing I've noticed that troubles me:

root@next:/home/support/btrfs-list-2.3# ./btrfs-list
NAME                      TYPE    REFER     EXCL  MOUNTPOINT
NEXT_ROOTFS                 fs       -    78.37G (single/dup, 
15.03G/95.46G free, 15.74%)
    [main]              mainvol   16.00k   16.00k /
    @System              subvol   16.00k   16.00k /.snapshots
    @Logs                subvol   16.00k   16.00k /next/logs/.snapshots
    @Logs/current        subvol    4.70G    4.70G /next/logs
    @AppData             subvol   16.00k   16.00k /next/appdata/.snapshots
    @AppData/current     subvol  370.14M  370.14M /next/appdata
    @AppData/var         subvol   16.00k   16.00k
    @Databases           subvol   16.00k   16.00k /next/databases/.snapshots
    @Databases/current   subvol  754.95M  754.95M /next/databases
    @MessageBus          subvol   16.00k   16.00k /next/mbus/.snapshots
    @MessageBus/current  subvol   67.70G   67.70G /next/mbus
    @Updates             subvol   16.00k   16.00k /next/updates/.snapshots
    @Updates/current     subvol    1.81G    1.81G /next/updates
    @SystemData          subvol   16.00k   16.00k 
/next/systemdata/.snapshots
    @SystemData/current  subvol    1.21G    1.21G /next/systemdata
    @System/prev         subvol    1.48G    1.48G
    @System/current      subvol  443.27M  443.27M /
root@next:/home/support/btrfs-list-2.3# du -hd1 /next/mbus
0       /next/mbus/.snapshots
1.4G    /next/mbus/redpanda
1.4G    /next/mbus

So, the MessageBus subvolume is occupying 67Gb (?), however I fail to 
understand how come this space is not accounted for by du and how I can 
clean it and limit it in future.

> On Fri, Apr 19, 2024 at 11:40 AM Skirnir Torvaldsson
> <skirnir.torvaldsson@gmail.com> wrote:
>> Dear btrfs experts,
>>
>> Could you please help me sort out the following situation:
>>
>> btrfs df reports my 100Gb device is almost out of space (which agrees with the results produced by the standard "df"):
>>
>> root@next:/home/support# btrfs fi df /
>> Data, single: total=82.00GiB, used=78.23GiB
>> System, DUP: total=32.00MiB, used=16.00KiB
>> Metadata, DUP: total=1.00GiB, used=153.70MiB
>> GlobalReserve, single: total=68.45MiB, used=0.00B
>> root@next:/home/support# df -h /
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/sda3        96G   79G   16G  84% /
>>
>> However  when I try to locate files to delete with du that's what I get:
>>
>> root@next:/home/support# du -hd1 /
>> 70M     /boot
>> 0       /dev
>> 2.2G    /.snapshots
>> 14M     /bin
>> 4.5M    /etc
>> 2.5M    /home
>> 348M    /lib
>> 4.0K    /lib64
>> 0       /media
>> 0       /mnt
>> 0       /opt
>> 0       /proc
>> 40K     /root
>> 2.7M    /run
>> 12M     /sbin
>> 0       /srv
>> 0       /sys
>> 0       /tmp
>> 566M    /usr
>> 5.0G    /var
>> 29G     /next
>> 38G     /
>>
>> I.e. almost 40Gb just gone somewhere.
> Huh?
>
> 2.2G + 5.0G + 29G + 38G == 75.2G out of 78G reported for DATA. What
> 40G are you talking about?
>
> If you have some other mount points, you could start with explaining
> your storage layout first.
>
>> Am I doing something wrong? Is there a problem or a piece of theory I'm missing? Kindly advice.
>>
>> +++++++++++++++++++++++++++++++++++++
>> root@next:~#  uname -a
>> Linux next 5.10.0-28-amd64 #1 SMP Debian 5.10.209-2 (2024-01-31) x86_64 GNU/Linux
>> root@next:~#  btrfs --version
>> btrfs-progs v5.10.1
>> root@next:~#  btrfs fi show
>> Label: 'NEXT_ROOTFS'  uuid: abc71bdb-c570-461d-a28a-54294a646089
>>          Total devices 1 FS bytes used 78.37GiB
>>          devid    1 size 95.46GiB used 84.06GiB path /dev/sda3
>>
>> root@next:~#  btrfs fi df /
>> Data, single: total=82.00GiB, used=78.22GiB
>> System, DUP: total=32.00MiB, used=16.00KiB
>> Metadata, DUP: total=1.00GiB, used=153.64MiB
>> GlobalReserve, single: total=68.45MiB, used=0.00B
>>


