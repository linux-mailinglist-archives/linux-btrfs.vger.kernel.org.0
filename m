Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E8F12DA41
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 17:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfLaQPN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 11:15:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:59211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfLaQPN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 11:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577808910;
        bh=OtAgXsVaxSz45qKCSAsIJHX4jeOwSjqGKiMpwOqHY9o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SYjdUsh35lXhD1ZcDXDOSehzkAp/f7k0cBC5YzvJc8CCBLBqM7M9VXv2Ilf6F3SmL
         NZuaulBxf1ztZJDycRe/j5fg9vUFJcd6BKD6S2wBdrDdbqqeNfyEV4xESqpeGikjKp
         C5KcJbrQOOq2ltB1LJh5Yn73zl3P/ow4AEvIMYRU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.24] ([77.10.141.27]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel7v-1jMTwB06h3-00aoWi; Tue, 31
 Dec 2019 17:15:10 +0100
Subject: Re: BTRFS with kernel 5.4.1: df -h shows 0 Bytes available but btrfs
 tells me that there are 1.06 TiB free
To:     Chris Murphy <lists@colorremedies.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <9df7f98b-271f-8b1d-f360-00a737d49911@gmx.de>
 <CAJCQCtSWW4ageK56PdHtSmgrFrDf_Qy0PbxZ5LSYYCbr3Z10ug@mail.gmail.com>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6c75e143-bae0-3057-f97b-eba9e7a068f6@gmx.de>
Date:   Tue, 31 Dec 2019 17:15:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSWW4ageK56PdHtSmgrFrDf_Qy0PbxZ5LSYYCbr3Z10ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:az3bPQtvYBF6Iyejbp5i3ZJCA/ey7gFZEqsIyjhH9zxBuwXEnyE
 KmM9pC1cCT+NGHVrzsFM+D4Xx0EEanJXA0zzBQKq4eYLlzxdwBgYa6kaSOkY0Gzmut3qhuM
 G4jDNPCfrNwIxvyfbjql8YV4ZPJvGFvcovfWz04npx9bl5M58+7QM5/iEBLFiradD8gJhZv
 Wih3gmZH+o6yN6i/swcrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c6ha+UPxl54=:pdLMqm6pMB2jfkykQeakTQ
 u84Hrr8/gw6dgFuVJbee3JC2sJKpaR7N6GUSEaDJKhk+7hP+SLpD5He/MQeM/jq0AYP5FHZCV
 dunUmNHQ5j8QUWPndM0YkRChWGj2GKwA91I3DtqFV2WbH1lmZ0+xWhR1yGkdUrmKtkN6n0/Z5
 rTNNEau0Ye0ODkbTwwrPi9J7SnetpEs5V9KuD2N90ZTsOfdAW1PbOUOrhjAUTcbTM4bEq+kiG
 IWK1G0vtP1yhYeDYKfW33Hl2IxJjeRQ9Cd8xy0+WuybNh7Rh28BvcP3PYaU1lBOKsuXCnqftG
 YaaX3cuYlvDN/ayqyBKgLijhnMkqz52Q7nzLc50fy6A6M4zlkNzeeZQWaimZVPNxneynyNv8H
 QoQATN0FjXJzIjdpZTk5ty7aStTh6F/vJGByuyXkA7HN0x60GUmMjr3VPdpn9Q4u+6zNDlXOl
 6xRm7lBAZ+Mt8Ha5b69tuhMvf6EELS+H3e3gW5HXHnJceaRYZi/FRhIpIqAC6UOtadSCIyfUp
 xDHUJwGuuvc6mrurrwGSFJ8CWtBF//UiHCJDJmk7d6/LPSp7trhtP8FCQtISKWpPxYsikpQWM
 7vSNIhTs0rzFGOe+rsnHqiqYdFtBRrq6PQpAj5WoB9p2fnrOK7EUpC+uCHXCNCySM4y9thNBL
 w8cfo5sYwzBc0xu10jUG3x92/Xh2Ugpa83cWXWVQ9QEM3DE2u9Ub3fL0ewXfZqPpUdEAf48E/
 dgTWcDqOgt4GMoA20qnFHc1hLLFqMJTV1+p4p27ecZxMOFTWWWbj6siGAmr/VUkz1fg54ortG
 CRgvGv9TkHn4oCr1uCLw0ZCD83jCWZqQleGbVp/76ohetL0Ikjd4W+CeKwZF/78iSBAjwjYDG
 PsxubcUvGwZvVzOnUXZty2JaiqeNAhuhf6psOlZP4i/wGDvtUeWstGrwbdHCSBjtKkLuWt3wF
 8UdDJ65md2nRKDhvwjN1MEDtFBfcMI4H1fyte6U75wi9x1pEVGNOn/gVR/h8jMNiwmNtC4IaB
 KaFbc0qaicqqEWazlpwpdD+D+d0SgzDrGH4S6gKWKGCZLCvNxLADMCSSrbzfemNnucAs47scb
 kvmQCJg0lMPPwLNGYrUPNUr3tOXHljSE5g57655KWqJO8dFvo6dnDgRrRawb71zfBecOk4L4e
 AOWhPOurB8xeJmongbQWA58uezeGAMe74YeKO78ini2QA4naVsbRyNYHCm0mMuxhsRlBNBsmi
 bX6HQJFh49KdvVOrDZz/2AN3usJaZO9GE51WGwMtsZV8BwLzsP3KAxT+fyjk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/19 7:58 PM, Chris Murphy wrote:
> Hi,
>
> Yes this is being discussed in two other threads:
>
> "df shows no available space in 5.4.1"
> "100% disk usage reported by "df", 60% disk usage reported by "btrfs
> fi usage" - this breaks userspace behaviour"
>
> Seems pretty clear there is a bug, it just needs to be located and fixed=
.
>
> --
> Chris Murphy
>

I checked the git log of the stable kernel v5.4..v5.4.7 but it seems this =
issue is not yet addressed in the stable tree, or?

=2D-
Toralf
