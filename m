Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D11DB2D2A
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2019 23:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfINVhD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Sep 2019 17:37:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44271 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfINVhC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Sep 2019 17:37:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id u40so38382207qth.11
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Sep 2019 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version;
        bh=yDq+/SiiVkfo2gjXraInXYz1jFFL2AMLdRdcrQ12W8o=;
        b=bH7xratInqTFLxvfmzns6nhL3epp0+7b0Qv05J6+wCeh6i3oU4tZOQE8QvuSTw5rBm
         UsJTThPCnwLODp0amEyRLh1Qf6vJ7ve0VXdrpwfMvhRoV/sZUgDcyUwSU4zuHXW2HIpO
         JpsMjIZVVBPhbE5D/OxO0xqBXGka36zTGHbPnL9tr0vvk78MtSoEAox7cRkgtVbcQHYU
         OdTfF45gwMpXlitEFtk3DmepWYRnr8RtHoTKLufNZgLCQ3Bw8Qw4juw/IKOe+RFnakEU
         13IOVkKHxtx6gYED4M24xhXXACnw4X95q4MlwuEMZ54oLABct7sswNTXGdyu0qH2AgWP
         Fp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version;
        bh=yDq+/SiiVkfo2gjXraInXYz1jFFL2AMLdRdcrQ12W8o=;
        b=joCKZbLZm++D2uTr+u/34VZCMV4M/LI6l9owsUSNAgLeKH1VwoTjpXhVBJUTtioz8n
         K5SKNZiEy8ALQYz3pVG76RzsevmCjqraCLbsVLMC3zmmE2c8JlItrK6vyrBTIwfxy+NN
         7548KaZ8lFMLEKJO7VqnTQhrz/+pEFjxfa801yIEgSnlt9ySzhW8iv2hPj33k/IWO62C
         E3Aiy3YjbR0IIa6MiUQoidImIwff5+T03EiUZWfHThHqrw69U+BnPFYeo1+xLJXyHUN0
         a8/dRmbH4rgl7H81rrvND3wbcn/fLg4qPwvp8WBGQGHfKHt6y8zabdsXvpHiS2IVDUAs
         ygwg==
X-Gm-Message-State: APjAAAURX8+eSIxdfE+Nyt+AQ8wEnj1/Dt1aCnIIOW6DBQ+/H/fJbxce
        SFw148c/d0Wy5+en6kc1npNerZOs
X-Google-Smtp-Source: APXvYqwyn4YUvF6nhXRG3EEn3tFecT54sfGDkDwDkQ3UKIeRe+80flCOaHiEeht3zzTeR6aDaFQmxg==
X-Received: by 2002:ad4:43e5:: with SMTP id f5mr32640973qvu.101.1568497021246;
        Sat, 14 Sep 2019 14:37:01 -0700 (PDT)
Received: from ?IPv6:2604:6000:1014:c7c6:3870:3b84:b31a:588b? ([2604:6000:1014:c7c6:3870:3b84:b31a:588b])
        by smtp.gmail.com with ESMTPSA id k199sm15978358qke.45.2019.09.14.14.36.59
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 14:37:00 -0700 (PDT)
Message-ID: <ef805fda2976d3b89b80204f8d119a9342176bae.camel@gmail.com>
Subject: while (1) in btrfs_relocate_block_group didn't end
From:   Cebtenzzre <cebtenzzre@gmail.com>
To:     linux-btrfs@vger.kernel.org
Date:   Sat, 14 Sep 2019 17:36:58 -0400
Content-Type: multipart/mixed; boundary="=-FXKFMY5XADEAblN0olw7"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--=-FXKFMY5XADEAblN0olw7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

I started a balance of one block group, and I saw this in dmesg:

BTRFS info (device sdi1): balance: start -dvrange=2236714319872..2236714319873
BTRFS info (device sdi1): relocating block group 2236714319872 flags data|raid0
BTRFS info (device sdi1): found 1 extents
BTRFS info (device sdi1): found 1 extents
BTRFS info (device sdi1): found 1 extents
BTRFS info (device sdi1): found 1 extents
BTRFS info (device sdi1): found 1 extents

It continued like that for a total of 754 lines until I rebooted. Before
that, I captured some debug info. I ran this in my shell for a few
seconds, where PID is the pid of the process that called the balance
ioctl:

integer i=0; while true; do sudo cat /proc/PID/stack >stack$i; sleep .01010101; i+=1; done

Which effectively gave me stack samples at (close to) 99Hz. Maybe not
ideal, but I was in a hurry and I didn't want my disks to sustain such
heavy, repetitive I/O for too long.

I've attached the stack samples as stacks.tar.gz. A few of them are
empty. To me, it looks like the kernel never left the while (1) loop in
btrfs_relocate_block_group. The kernel messages seem to confirm this.

I am using Arch Linux with kernel version 5.2.14-arch2, and I specified
"slub_debug=P,kmalloc-2k" in the kernel cmdline to detect and protect
against a use-after-free that I found when I had KASAN enabled. Would
that kernel parameter result in a silent retry if it hit the use-after-
free?
-- 
Cebtenzzre <cebtenzzre@gmail.com>

--=-FXKFMY5XADEAblN0olw7
Content-Type: application/x-compressed-tar; name="stacks.tar.gz"
Content-Disposition: attachment; filename="stacks.tar.gz"
Content-Transfer-Encoding: base64

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
Z7x8/bhYq2Bc7GPbpc/ImXh1XPHSmevp3zbbKLZR1/o/S/+3M5ufDb7/Uf+L/5n/cpPzX9AYGiNu
8ft/qcf/1H/jf/yP//E//ieE/F/p8T/1n/gf/+N//I//CSH/BzX+5/x3/I//8T/+x/+ElP9zzX/h
/n9e/19X/w3v4T1xD/xv9PCf+7/wH/7Df0KO/41Rw3/mv8B/+A//CUn+WzX8Z/4L/If/8J+Q5L/T
w3/6/+E//If/hCD/Cz38Z/4X/If/8J8Q5L/Xw3/O/4b/8B/+E4L8zzL/Icbw+S/znzJc/zz9v37z
ZW/Q/8P574L+Z/4n8z+Z/5ln/ue53XH6x8LumN2xoP+z9P/aEOzQ/9T/4X/6f2+n/xeN3aTGjvlf
a+F/Zaj/g//wH/7Df0H+N3r4T/0f/If/8B/+i/HfmTz9n4Uf3v8p4b8g/095FHGxw1E9OxTC+XXt
4b/S/f38uOKYWj/ZM6960I3Da7p/3pL4mWj/ds7VLZzjdj1x6f6/M1n6P00oR/jP/C/d9X9w8C44
eJz/Tk/+8/yP/Cf/hfO/UJP/zH8g/8l/6fz3evKf+z/kP/kvnP+lnvyn/5v8J/+F87/Sk//0/5L/
5L9w/gc9+U//H/lP/gvnf60n/+n/Jv/Jf+H8b/TkP8//yX/yXzb/bZb6z9H5L577/yJxfP2z1H85
4yvqv7Lyn/4P+j/e7/znnbDj2zbF6B94ZiMQHJsHiqiJXP53evxP/Sf+x//4H//jf0LI/0V+/8f/
H/1P/Rf+x//4H//jf0LI/3nOf/F2xP/Ufwr6n/kfeA7PfUTPHfM/S/+PNW6E/zz/F+T/ded/wUE4
SNwD/ys9/Of+H/yH//CfEOR/0MN/7v/Af/gP/wlB/td6+E//N/yH//CfEOR/o4f/9P/Df/gP/wk5
/rs85/944wf89/BfkP83UP+7+9lvk++zeQJfpKbdo3FbBLQh39O339su1eYWTcLZa6p+sB22+7j8
zzL/YXT/75n/wP4fIkJEQpD/Tg//6f+H//Af/hOC/C/U8L/k/C/4D//hPyHIf6+H//R/wX/4D/8J
Qf4r6v+l/wv+w3/4TwjyP0v/ryuLcsB/zn+W5P99zf/brDsz/8+GNw4A3C7r5xGl4X/xTdq6x+vJ
4slu3X4C4CS9tE1n4xTh+fXpxZvR93e49HQWYS+c2aVf2a0tzZgW33tq4cg6Oxv7fPfzotLa1bd1
/9bSgULxb/AXRxwerg/xM15eWr343K1/HG4q0meXNgDF4BPZ7onmq++rrw8/Jt1qlcZROVdf2ISM
bqT8sn5uI/XYdukzciZeHVe89Myl9G+bbRTbqGv9H/T4n+9/+B//43/8j//xv5D/85z/fHT+467+
j/7/DNc/T/+vL4f3/zn/W3L/9+7znw9mOK+6Rdu1i/26Ku5rrD27A4i/0+9r0qbJR0fY6euF3iB0
hM5zkdfwv1Bw/vOW/wX8z3D9c53/7Kn/5f4P5z/dyflP7HrY9RC36H+nx//Uf+B//I//8T/+J4T8
X+jxP/Uf+B//43/8j/8JIf/nOv/Zc/7PfT3//xDnP+M5PHdf/M/V/83937z8v67/Gw7CQeIe+F/p
4T/3/+A//If/hCD/gx7+c/8H/sN/+E8I8r/Ww3/6P+E//If/hCD/Gz38p/8P/sN/+E/I8d8bNfzn
/Gf4D//hPyHJf6uH/5z/DP/hP/wnBPmfpf9/fP4j838yXP88/Z++csP7f5z/Leh/5n8z/5v533nG
hZ7bHad/LOyO2R0L+t8r8L/l/C/8j//xP/7H//hf1P95+n+9KQb+p/5T0v93eP6DLZYAHaDzuOM1
/K/08J/6H/gP/+E//Bfkf9DDf+p/4D/8h//wX5D/Wfp/nbXl8PkP9T88/1Ez//tVj3+2zyQ2L9nO
4rImCtTNXz5T3FYtM8UxKSYlhP2fp/87BDvwf8D/+J/zP3A1rv5TXX3E/9Ko4T/f/+A//If/8F+S
/1YP/6n/hv/wH/7Df0H+Z+n/toUf8p/53zf9/P9+z3+DczyTuNf7/2WW+Q8mlNz/ycv/N8x/goN3
wcHj/Pd68p/v/+Q/+S+c/6We/Of8P/Kf/BfO/0pP/nP/h/wn/4XzP+jJf+Y/kP/kv3D+13ryn/5/
8p/8F87/Rk/+0/9N/pP/svlfZan/Ppn/3+e/5/6//PPfKkv9p4vnTjD/Lyf/mf/7TAHo2AjdNMiE
EboKRugenEW12yzEj8kUo8WxZzYhwbFxoYDrY/s/S/2vM74a+p/zf/A//R+30/+Bg3EwceP+L9T4
n/pv/I//8T/+x/+ElP+z9H9Ybyv6P7L6n/5fPIfnPqLnjvmf5/w347j/m5f/b6j/gYNwkLgz/ldq
+M/9P/gP/+E/Icn/oIf/3P+B//Af/hOC/K/18J/5L/Af/sN/QpD/jR7+M/8H/sN/+E/I8T8YNfxn
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
QAAQCQA=


--=-FXKFMY5XADEAblN0olw7--

