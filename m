Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FF517F1CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 09:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCJIWI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 04:22:08 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37492 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgCJIWI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 04:22:08 -0400
Received: by mail-wr1-f50.google.com with SMTP id 6so14592627wre.4
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Mar 2020 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=PDTPenyasgt8nEqE85dcQuStLw5FGwlrB9l4/aRl3xI=;
        b=Zih9gG/Ir28tLNHHWcUryMwPUvX7wU6Gjp47Vr4GlQfuCJvsPxJ42BGr0osHgWuRkY
         EvgZJRN/Y/LvbhJeiufjQkm8uvwT7Fv4DB6l9Hrp1f2soqdpDsTZmSyClOGxmny7h3Sg
         QPo2BzAVal/e+7TTah54Tc6EfSNGit+5woxakBuZi+A5LuWph8YHgxesmR+oJqmnFQrk
         gfpKetQ4SvGR+l/098k+H04iHOGS1/u4aNyAmG+46MyvU2wCgpqWCuYh4vz/+l1QEmO0
         sRkbFeU1VsMQMCb6OdM47Vc4cSncBBppvPWvgJSQ8rdYrY5HylqufaxyGGwsxh/vShIH
         H3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=PDTPenyasgt8nEqE85dcQuStLw5FGwlrB9l4/aRl3xI=;
        b=fkA139PsyiCaLrZJnuHQV2HN645CNoFSBAxEgEI+0nLoW2Yljnh+31CY3d+QKqxRpo
         aIbF8eniLcHHPptTLR7WEy79K8aa8KsjPIrnouq6lBG7IQDSN74Zg5hausELznCI3LfH
         a3UPQmP49q6x0q4uid6HTN7g25VrRCUB+IB3W14AB2cdtdaOW0yOBNqUmOVm7ryKS+9v
         Ccrk8f41MxIKStzLZfILOIP0vUNIdPTsbIfTjyfevUxxjvwq/vS0gJB8aP0W6EUWY5dU
         7D9HSIlXzzy3MIVYVQPFHOcXRpxwJZrWYh/2V5z+QO7CN5G7nxlMUSIdD3XwblHWJZYr
         P3QQ==
X-Gm-Message-State: ANhLgQ0nRFD7dTKB6OdZ7kraW+ksHNBuG5iJXnboORA4WuOH8Xtvoj5u
        ZW7QN0oiB1hec2x+GMLh+RE8BWyq
X-Google-Smtp-Source: ADFU+vsUfOCppDVx5BwG4EPLRWgaLb/khFBmhqgFnWBeT6Oer7671waEThNZOCCWvrWU+rjCwNXSTQ==
X-Received: by 2002:adf:c648:: with SMTP id u8mr17943047wrg.185.1583828526032;
        Tue, 10 Mar 2020 01:22:06 -0700 (PDT)
Received: from [192.168.1.53] (5-13-5-212.residential.rdsnet.ro. [5.13.5.212])
        by smtp.gmail.com with ESMTPSA id 2sm29864919wrf.79.2020.03.10.01.22.04
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 01:22:05 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   "hodea.stefan@gmail.com" <hodea.stefan@gmail.com>
Subject: Help with my btfrs corruption after a power failure!
Message-ID: <331f2df8-3eee-0186-eb41-4f0edd1bce9c@gmail.com>
Date:   Tue, 10 Mar 2020 10:22:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello! I need some tips on how to repair the btrfs partition, following 
repeated power outages from home.
The situation: For several months I have stopped using xpenology in 
favor of another dedicated Linux distribution for network storage (at 
another location I ran into the same btrfs corruption issue, but then I 
didn't have much data on the server and I didn't shake my head. in 
solving the problem). Now being the NAS server on which all the family 
documents can be found. On it are installed 3 hdds: one of 2 Tb and 2 of 
1 Gb configured in raid1 since using xpenology. The tried commands were:

btrfs scrub start /srv/dev-disk-by-label-2018.05.11-19-05-54 \ v15266 /
btrfs scrub status -dR /srv/dev-disk-by-label-2018.05.11-19-05-54 \ v15266 /

And

btrfs check --check-data-csum / dev / md126
Checking filesystem on / dev / md126
UUID: 3ce16830-f95b-4f0c-b96f-bd6f10c435e2
checking extents
checksum verify failed on 358432768 found 5BFBA855 wanted 0F952A4E
checksum verify failed on 358432768 found 5BFBA855 wanted 0F952A4E
Invalid key type (BLOCK_GROUP_ITEM) found in root (202)
ignoring invalid key
Invalid key type (BLOCK_GROUP_ITEM) found in root (202)
ignoring invalid key
Invalid key type (BLOCK_GROUP_ITEM) found in root (202)
ignoring invalid key
Invalid key type (BLOCK_GROUP_ITEM) found in root (202)
ignoring invalid key
Invalid key type (BLOCK_GROUP_ITEM) found in root (202)
ignoring invalid key

What is more surprising to me is, that partition configured with raid1 
btrfs have been corrupted from those power outages.

Thank you for your attention

Regards,
Stefan Hodea

