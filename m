Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA64D3D46A7
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhGXIpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 04:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhGXIpY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 04:45:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8411CC061575
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 02:25:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b7so4863657wri.8
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesmariamoliner-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=4Is3Ew10RVUYgRbdKdmNAS/ZuutwxhwzXe6vJR82GEs=;
        b=fRE9AT8TW8fCvA1YmJPZItAlD0G4ah5PYkBhJAo+zKURofGbI8e7TCJIgjzgbUswbm
         H5+xP0IphEWv/HYuZJSgGL5n63YHCZ3O6xHugILnOc/dTaKAzgzGDsAjFUY2cY39+9A/
         3huC4Yx1UfkmoX/b4feQOyCK9vBoVPsByh0B3OplTSxl1DjsFcDli2lfAFEJh3fzIyKI
         7dXrwfjDOLYtkhw3U1cF9KGjZ7hzHQeE4imOGhuv4DDRpbWFol+JGbM9EtfiZeCpJmfw
         uMOhrrW+OeXgoTaMjppS+lCLIV8tDBbnzwO2Hn6+2d028qnqjiaJFWEtlQIjFWOYXsXV
         XWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=4Is3Ew10RVUYgRbdKdmNAS/ZuutwxhwzXe6vJR82GEs=;
        b=dqh9JDpSrHusAE20WPjxKQbGnGH2HItjgzEerjUhJUozo/DzehJlMNM1m7jhZGWk/V
         B7RXZTIPuzXRabAA/27UImQeKe6zKWcR0MgIVxvTD7FHCgbnTUnl5Rnl/uopNUnRVaB1
         6ePhB7OWcZtUKiiyy6jtt+480CZK1vUXC8p1NCbOKgmDbcqMZUYE19/W+yLZrswelr92
         yxKBgZjfTQAnQbWsEv3czPmx/nWzVyp91ZJJJwNoqUkFbkkuOATZv6vYt8F2t8KGzsDG
         E/xsjowD8FjfI8X4bRNQJV/vJXwoj9Zrln1yahJQT1jCtC8tNIPwtej6+v1RUzqr/dNv
         HSEw==
X-Gm-Message-State: AOAM530/6QGp4Mq8yO0RRIq3L+b+2Y+2yv3XW5/7ECK+aybWDw/uJig1
        gDkmgPQkWjYulkojrfREcRcTTgYdbZa+Zw==
X-Google-Smtp-Source: ABdhPJwpwDiE4hdIJMBQh+wE05KdEsp9FeJCOBEhHG9hDj+AlddhkDxCxA3YKHdv3ck57So5KINHzQ==
X-Received: by 2002:a05:6000:1d1:: with SMTP id t17mr9068927wrx.267.1627118754033;
        Sat, 24 Jul 2021 02:25:54 -0700 (PDT)
Received: from [192.168.2.3] (188.red-81-44-181.dynamicip.rima-tde.net. [81.44.181.188])
        by smtp.gmail.com with ESMTPSA id y6sm29430702wma.48.2021.07.24.02.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 02:25:53 -0700 (PDT)
From:   Fernando Peral <fperal@iesmariamoliner.com>
To:     linux-btrfs@vger.kernel.org
Subject: Help Dealing with BTRFS errors on a root partition in NVMe M2 PCIe
Message-ID: <26346381-4981-0e95-9cf6-4bbfc6e9bf18@iesmariamoliner.com>
Date:   Sat, 24 Jul 2021 11:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: es-ES
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.

I'm having an error on the root partition of a opensuse leap 15.3 system.

I have been asking for help in the opensuse forums

The problem seems to have been caused by a faulty ram module wich has 
been already replaced, but the error of the fs is still there.

It has been suggested that it has been a bitflip and to ask here if a 
btrfs check and repair should be done.



#btrfs
check --readonly --force /dev/nvme0n1p1
[1/7] checking root items
[2/7] checking extents
data backref 227831808 root 263 owner 7983 offset 0 num_refs 0 not found
in extent tree
incorrect local backref count on 227831808 root 263 owner 7983 offset 0
found 1 wanted 0 back 0x5559e0ab7020
incorrect local backref count on 227831808 root 263 owner
140737488363311offset 0 found 0 wanted 1 back 0x5559dde718d0
backref disk bytenr does not match extent record, bytenr=227831808, ref
bytenr=0
backpointer mismatch on [227831808 4096]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7]checking free space cache
[4/7]checking fs roots
[5/7]checking only csums items (without verifying data)
[6/7]checking root refs
[7/7]checking quota groups
Qgroup are marked as inconsistent.
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p1
UUID: 5b000355-3a1a-49f5-8005-f10668008aa7
Rescan hasn't been initialized, a difference in qgroup accounting is
expected
found 51878920192 bytes used, error(s) found
total csum bytes: 48135312
total tree bytes: 991313920
total fs tree bytes: 885358592
total extent tree bytes: 48414720
btree space waste bytes: 151592274
file data blocks allocated: 239972728832
referenced 85539778560


pruebas:~# uname -a
Linux pruebas 5.3.18-59.13-default #1 SMP Tue Jul 6
07:33:56 UTC 2021 (23ab94f) x86_64 x86_64 x86_64 GNU/Linux


pruebas:~#btrfs --version
btrfs-progs v4.19.1 Â Ã§

pruebas:~# btrfs fi show
Label: none  uuid: 5b000355-3a1a-49f5-8005-f10668008aa7
Totaldevices 1 FS bytes used 48.42GiB
devid  1 size 931.51GiB used 51.05GiB path /dev/nvme0n1p1


pruebas:~#btrfs fi df /
Data, single: total=49.01GiB, used=47.48GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=2.01GiB, used=962.69MiB
GlobalReserve, single: total=101.06MiB, used=0.00B


-- 
Fernando Peral Pérez
I.E.S. María Moliner.
Departamento de Electrónica
Tfno: 921427011
Fax: 921444366
Telegram: @fperal
Linkedin: www.linkedin.com/in/fppmm

