Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8212B4B9603
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 03:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiBQCoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 21:44:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBQCoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 21:44:10 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37512A795B
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 18:43:56 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 124so10085256ybn.11
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 18:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/QkKtSXemwTFuylz9XLrPeswdUMi2haF3fi1YDt57Y=;
        b=iwN9G1QzRZpa1YZYs7q4R2RcJwXBSaDsVzhVGWmUyvwsjLkuDwL2J6AXtycO4rqdOi
         AfBZ2f6j0aGu1aJnRk/rv1AJvyyUUkh8+eONk7FiamnVOeSyf0gDkmMHkDhm9RwhmJaJ
         0PMFNDajI1YCrJRKwF72L4zjeLHzxoEWZXjViehWC0fn1p/46XT7GX6NdhymgQFjlUtD
         hLIvC0gYJoagY5vfNVs/bHRAEiRvItqbiaiXtlIf+sl24ImX+a35SjAArDtcJUXZ3PW4
         jdlGIcsK1MPQ/5P7HTkHmrsEp6lsv5/6AmOcT8DYJhDBBOLMDFUD/eoywaTW6wkW8918
         2aLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/QkKtSXemwTFuylz9XLrPeswdUMi2haF3fi1YDt57Y=;
        b=WME3Y6UaXFEJzxTpnJxtabZW9V+f58GKd9sLWFVI34J2d2nmpFL7Jlzr+9GOhlejh+
         EE1PlQ39sCfJH7PrsbA0ih0jUo0ATyYAPMkXk4VdVLTJtfSfWUxTYAGR/qzkfMj3HQ6f
         A4Ulp97q8u/kADmeKRbJlDQk0Q6ahZhcoCtrlXLtBW5/acczUmBvv2/yEbgRtqnd593J
         Jf2W70IL/f5I0QnKK+jypjyl4W6tdwbpigPcXVCRBxiyik/cjO8xPZMyP+T9vwD4jR5w
         u5QKRTrZPBrQXsAU39X15qrz1W2rJ42MfIdZXj1hFDRFe4lzi/pgZlnDY+CzFQUhoR57
         Tx0w==
X-Gm-Message-State: AOAM533vp0nsEdzJVCyJbp2eozIAI4vfv/rN2Qfbauv8c2x5fTBt8BGi
        FQUWFxbDlFSOaTtWv6YNb54bU/5NIQDneesVSXn2HV9n9Ix8w8m6
X-Google-Smtp-Source: ABdhPJyhkLZJsudDRReKgWsznhYNe3l2g7PLGwHI8CkHPifrffoWv3mE67EWe4H4Mb73W9OhO2xHR9hsPjicC9zo9C0=
X-Received: by 2002:a25:d986:0:b0:624:ddc:ff9 with SMTP id q128-20020a25d986000000b006240ddc0ff9mr668000ybg.509.1645065836007;
 Wed, 16 Feb 2022 18:43:56 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSGV2SK8u-9p=W6vh5DJFdG2zRj+6qb_4K6pUYb+sfqYA@mail.gmail.com>
In-Reply-To: <CAJCQCtSGV2SK8u-9p=W6vh5DJFdG2zRj+6qb_4K6pUYb+sfqYA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 16 Feb 2022 19:43:40 -0700
Message-ID: <CAJCQCtQNUODB7ANLFVaeBU3_Z2DaWKajKV6iRcahssuCxg9Ozw@mail.gmail.com>
Subject: Re: 5.17-rc4, oops, RIP: 0010:kyber_bio_merge+0x6e/0xd0
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filtered that snippet for systemd too, which resulted in this line
being omitted:

> [   13.086281] kernel: CPU: 4 PID: 628 Comm: systemd-udevd Not tainted 5.17.0-0.rc4.96.fc36.x86_64+debug #1

My guess is this is about the time udev applies this rule:

$ cat /etc/udev/rules.d/60-block-scheduler.rules
# set kyber scheduler for NVMe disks
ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="nvme[0-9]*",
ENV{DEVTYPE}=="disk", ATTR{queue/scheduler}="kyber"

# set mq-deadline scheduler for everything else
ACTION=="add|change", SUBSYSTEM=="block",
KERNEL=="sd[a-z]|mmcblk[0-9]*|loop[0-9]*", ENV{DEVTYPE}=="disk",
ATTR{queue/scheduler}="mq-deadline"


So it might be the switch from mq-deadline to kyber that results in
the transient oops. The boot drive is NVMe.

KXG6AZNV512G TOSHIBA

$ sudo nvme id-ctrl /dev/nvme0n1
NVME Identify Controller:
vid       : 0x1179
ssvid     : 0x1179
...
mn        : KXG6AZNV512G TOSHIBA
fr        : 5108AGLA
rab       : 3
ieee      : 8ce38e
cmic      : 0
mdts      : 9
cntlid    : 0
ver       : 0x10300
rtd3r     : 0x186a0
rtd3e     : 0x7a120
oaes      : 0x200
ctratt    : 0x2
rrls      : 0
cntrltype : 0
fguid     :
crdt1     : 0
crdt2     : 0
crdt3     : 0
oacs      : 0x1f
acl       : 3
aerl      : 7
frmw      : 0x14
lpa       : 0xe
elpe      : 255
npss      : 5
avscc     : 0
apsta     : 0x1
wctemp    : 351
cctemp    : 355
mtfa      : 20
hmpre     : 0
hmmin     : 0
tnvmcap   : 512110190592
unvmcap   : 0
rpmbs     : 0
edstt     : 14
dsto      : 1
fwug      : 255
kas       : 0
hctma     : 0
mntmt     : 0
mxtmt     : 0
sanicap   : 0x3
hmminds   : 0
hmmaxd    : 0
nsetidmax : 0
endgidmax : 0
anatt     : 0
anacap    : 0
anagrpmax : 0
nanagrpid : 0
pels      : 0
sqes      : 0x66
cqes      : 0x44
maxcmd    : 0
nn        : 1
oncs      : 0x5f
fuses     : 0x1
fna       : 0x4
vwc       : 0x1
awun      : 31
awupf     : 0
nvscc     : 0
nwpc      : 0
acwu      : 31
sgls      : 0
mnan      : 0
subnqn    : nqn.2017-03.jp.co.toshiba:KXG6AZNV512G TOSHIBA:
ioccsz    : 0
iorcsz    : 0
icdoff    : 0
ctrattr   : 0
msdbd     : 0
ps    0 : mp:8.00W operational enlat:1 exlat:1 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:3.90W operational enlat:1 exlat:1 rrt:1 rrl:1
          rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:2.00W operational enlat:1 exlat:1 rrt:2 rrl:2
          rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.0500W non-operational enlat:1500 exlat:1500 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0050W non-operational enlat:6000 exlat:14000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:- active_power:-
ps    5 : mp:0.0030W non-operational enlat:50000 exlat:80000 rrt:5 rrl:5
          rwt:5 rwl:5 idle_power:- active_power:-






-- 
Chris Murphy
