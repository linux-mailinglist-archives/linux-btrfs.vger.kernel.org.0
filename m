Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568193E01CF
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 15:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhHDNUA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 09:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbhHDNUA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Aug 2021 09:20:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B76CC0613D5
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Aug 2021 06:19:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ec13so3538631edb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Aug 2021 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=NFS9ubkU3ATLvgKdPjh8WbkmlYy8Zb1AquoC1/cuMaE=;
        b=EOUB8P/BM0vz2Uv/f+QI8ijy7qZmLDa/WsjvD2LX/EcWcq0bD1ARNjk894q/kSlWuN
         C3qzw02xWDqgMICCCp9efRoiLJ6AqadrN7aazdVBvpGh1ofH+5a20d2lZ2AVF+3E0Vnu
         UCmrYUPdz5wpb2N7VGhiULOZ85XX75wsD7J3Q+ESOiVfVnmBdE0WaBvRE9rPLzpy2PEz
         WUr61HtjPK9q//q1iKCpUKvlejjSqnm2CbE2jVp5r/qDdNfb7mx/NzMH9Yxmt6RTg4FO
         QFM/oQ50Z2tYJrBR4vbmg47y9+WuwKUMBqtmDLmE9r6zGfM2Oi574KeCUzTY3DPceKfD
         Kesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=NFS9ubkU3ATLvgKdPjh8WbkmlYy8Zb1AquoC1/cuMaE=;
        b=nrNJh1UGuLLyHN9dyzE77YcPyRTnMFwc5RAoOTSbRCkGgOsZcghkrR6oLfhtJEydaC
         wtkZyb55bXRchuOR9fVx8C/ngwd+RnpTLkA2lnwfr/U56nQyLuENbF8JqgRstmTZsSUH
         XbtgvmvvBl/ZQWjQ7n7CXZrY2CLnNQd6/VR8X61VdteQ683u8H6Dp74Nq/+0di0L549z
         hEKdSjGJyeK+DmYRe+zS0KUgbwSzHKD4XhvkuFeVJCAFkav204462k+G/YUD6QFE8C5n
         wSNJO9TFyFVa4AbW6rMVlp8fKlQ8BbWpYqaUe6P2oGnQo/bt7CfllIyTDfiD3fr9QQg9
         m6Pw==
X-Gm-Message-State: AOAM531If0AYdYEZV4qFWRvPUMwDHzDpQaBRCcdgkWK7WLwl3cZ9e01t
        RLYd/Na6unlQkzO/9e2Eo4NON9XPbB9yRKw1
X-Google-Smtp-Source: ABdhPJw+u6+Zh3ToBCao6nYDHWC5p/pL2zSuJgq4fx3I0R7rgrcr2eUVcqDvGi5xlokGHQKBijVjIg==
X-Received: by 2002:a05:6402:b83:: with SMTP id cf3mr31924118edb.12.1628083184769;
        Wed, 04 Aug 2021 06:19:44 -0700 (PDT)
Received: from [192.168.1.15] (lfbn-idf3-1-1070-247.w90-46.abo.wanadoo.fr. [90.46.24.247])
        by smtp.gmail.com with ESMTPSA id v17sm944486edc.47.2021.08.04.06.19.44
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 06:19:44 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   k g <klimaax@gmail.com>
Subject: Files/Folders invisibles with 'ls -a' but can 'cd' to folder
Message-ID: <94bf3fad-fd41-ecc0-404c-ccd087fca05d@gmail.com>
Date:   Wed, 4 Aug 2021 15:19:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi


As I say in my subject, I'm facing a weird problem with my btrfs
partition (I already sent this message on reddit /r/btrfs/ )

It's in fact a btrfs partition in a raid5 synology system.



3 days ago, the volume 'crashed' (synology terms) ,however SMART data is
ok and I don't have sector relcocation errors or CRC.... I rebooted
several times , and after dozen of reboots my partition shows up , but 3
TB of 10 TB are missing, I made a scrub but it did made my missing files
appears.



desperately I made a 'cd xyz' in a directory (I remember some of the
folder names) and it works ; and inside this folder I can do "ls" and
all files and subfolders appears .

I made a copy elsewhere of some files and these ones are not corrupted
or bit roted.



I don't want to make a btrfs check --repair of course.



Is there a way to "relink" indexes/root or whatever it is called to
bring back these files/folder visible and accessible with a safe command ?

I'm planning to backup all , is 'btrfs restore' will access to these
"non visible" directories ?



"I saw similar case here : The Directory Who Wasn't There : btrfs
(reddit.com) , but I can't find a reply that solve the problem"



cdly

