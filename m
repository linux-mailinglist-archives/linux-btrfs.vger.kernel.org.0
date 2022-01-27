Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5B49E5FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 16:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiA0PZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 10:25:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:56791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237296AbiA0PZd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 10:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643297131;
        bh=ipJlkB90IVkmTYJpgOz8xrZ1NinnsPlSN8fiBTibGMY=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=JWie7ZevCgh+zw8aWn1kAEWb/hL/u93zXeZTr04XjDtyfOEnE56SwizurdaB4qKkF
         GAncUSOTDJ3bWbZG3pKII0rdGXbQ3yAmFzFc1WLnBbf1vTOGSaDK0coi9OYzY0oP20
         JuebXOF08+UOHKAa/R2OT+Bh5G/qH+fs3giGSVQI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.212] ([86.8.113.40]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIdiZ-1n1EY347oT-00EZx3 for
 <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 16:25:31 +0100
Message-ID: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
Date:   Thu, 27 Jan 2022 15:25:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     linux-btrfs@vger.kernel.org
Content-Language: en-GB
From:   piorunz <piorunz@gmx.com>
Subject: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rwoZn9I3k5LTWhXnN3RUwi9pgUvnvIkXT92tn6TdgVYCTBxuTE6
 Iijy4DTL2YqjXRFFrHDnBy33AqReemS9XXdqihqKbLEXtsz4upvAVG5OU+VRGVyiN/RL22n
 ymuCZkXx/lnhL7HYlxFkEj4mMU84UEWbDcE0QgrCNZJ2tiXqxRSq/Y9gpq/bL/ZuO/AUGXl
 F3GY7BGTw6IjMqntFhfDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MeZmmRAtoYA=:c24SkCvpyvUriquueCjrRO
 4w3VjNSHQXXeSrvNLb3J5eu2gHx0IBf4gggAzPriup8U5p1jSW9QuMpvy0JglcayYLCFkONCO
 ajPA5AJ1mrF7/qOUlnDhjyz6GWIQsKJ9PMi7d8OeNgDDJry8C89btNip8XXu3bAOT560AI6JC
 +8vV7SRuN8k87BDoiHwSq/rai+WudvfSrb2NfTL86oNolLxqXGfDtS9tchx31tgTbQIuuOZiV
 9bpKEUlBMU+YHEWhidcOLF5+1qolc4YCDl9sJsciJ9w/FAouxOQg3WsNe6pPR1YEfvP8n4ssL
 THlhmeoOCNGdjJ1sfVkXKn8Gm/hkBzwrO2sknPG0lFS/IdDgrGs7346kDE/ZdALgrzvW/e0LG
 dZk48z9JjauQ/0a93RiM8VQu3AiJN4SHLESGTYFcUZTMW+qF7rI1gtGHx12FDi4rzrvlM0U2J
 nekRhnraAcK02XJ+tT9l9tU6h4Kdch+fkBitu0YdOSg0FPWVClAme8XWUyN7//8zlPVL5CXam
 XovlCp9AS2LIn7S0Lh48D3DIgHdh5t3avJ0mnmrrbZkzZ5/dV9DxeCUMAhqZL8KsGBJ63XYAi
 IDOzVmTxpsObYL6dQ6jiZM3jY1o9VjjpZY8H6jkNtc9GKZCt07LgYcJkV5cpBh0HneBIKtRDZ
 ykh+Huugol/nJXTi1DgJyYJy7H72TyBxNb1Sb25Lw6KYoXNKDuWrkBn/cKjTqsazqTzqiAOtw
 F52M/wECdX+Jr38fW9iKZTnN6J21iVV3+Jv0Y3ULkAMNLZ6z2Yyky+PmrBzRzn+/B504u8JGX
 aYKHxbImDkbGKWBhc34aP/tSr5cFEejfCNLbUFWUzJHgP28Bx/PMzuVdCs8vUWpeGfH4tYvNm
 Wq/0WKXD+Z7OX/g5ozUUZtGrIe+Ep2BSP0kjGK36ifPMbWNyZEtWnVl9fIzVwA0b5mtJn2vz2
 DCnMLsV+DGTDst4YzRVqzLZ/biHrR3UgZLoklxTbWH2ZXcLrWBTSN31WL8A0UwjDFfIbYTsHw
 GwLuu6Pp1BPV9SH2v5Ti3LUU6JRr3U8THdVLra+9rXmChdwuZR3gh7XrWZ0Eeem0Mr6u1oD9V
 Iz0nlD5pae3ZAE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

Is it safe & recommended to run autodefrag mount option in fstab?
I am considering two machines here, normal desktop which has Btrfs as
/home, and server with VM and other databases also btrfs /home. Both
Btrfs RAID10 types. Both are heavily fragmented. I never defragmented
them, in fact. I run Debian 11 on server (kernel 5.10) and Debian
Testing (kernel 5.15) on desktop.

Running manual defrag on server machine, like:
sudo btrfs filesystem defrag -v -t4G -r /home
takes ages and can cause 120 second timeout kernel error in dmesg due to
service timeouts. I prefer to autodefrag gradually, overtime, mount
option seems to be good for that.

My current fstab mounting:

noatime,space_cache=3Dv2,compress-force=3Dzstd:3 0 2

Will autodefrag break COW files? Like I copy paste a file and I save
space, but defrag with destroy this space saving?
Also, will autodefrag compress files automatically, as mount option
enforces (compress-force=3Dzstd:3)?

Any suggestions welcome.


=2D-
With kindest regards, Piotr.

=E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80
=E2=A3=BE=E2=A0=81=E2=A2=A0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 Debian - T=
he universal operating system
=E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80 https://ww=
w.debian.org/
=E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80=E2=A0=80=E2=A0=80=E2=A0=80
