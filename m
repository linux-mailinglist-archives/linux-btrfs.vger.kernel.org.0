Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A596CADD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 20:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjC0Ssh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 14:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjC0Sse (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 14:48:34 -0400
Received: from mta-p5.oit.umn.edu (mta-p5.oit.umn.edu [134.84.196.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08501716
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 11:48:33 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4PlhfT382nzB3DjP
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 18:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id irzcd3Vz6JRY for <linux-btrfs@vger.kernel.org>;
        Mon, 27 Mar 2023 13:48:33 -0500 (CDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4PlhfT171hzB3DjD
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 13:48:33 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4PlhfT171hzB3DjD
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4PlhfT171hzB3DjD
Received: by mail-pj1-f72.google.com with SMTP id cp21-20020a17090afb9500b0023c061f2bd0so5033731pjb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google; t=1679942912;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IbXAXnTGc/xHg3hKn4r7D6l2shHmAGfEABmnJKW3WWE=;
        b=EvyVlVexDniqLYR6BpHMzxl3tRuW6Lzo13WjmPwZECspAg7gKqSsEH7X2HQmbzPC6O
         RQp46e4SWXO5cNGxUIFXofYAAy7fkG6cJ5kgkJ+EfcYOYWIg98Nq5zuSStVVxCDqHEjm
         PEKMAMAlRXdjFpKdQsLFYFAQwZTPpFrR0kwfmU7mcUH8wDNTZWoSSJ+U5plm3w9vlaKn
         Ri1QwvkyrTWGTn9SooWqnMf+9WJ+178/KZidu22G3Y6ibutACYrvHFi024btTu0SjJPC
         jq575aYvhIOgjxKdSazOzD2H9AaVzbsyi/yKqSXtGU9V2v/2oz1IDp81b28x6HnhZRHA
         9YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679942912;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbXAXnTGc/xHg3hKn4r7D6l2shHmAGfEABmnJKW3WWE=;
        b=BtIlAwyqhq/zrcpRVrbbywD4Hk/d1vRoWrNlPqzYY15+NCfrzoV3O81nORJK+A2/Ds
         svtmFvs7dlV9biwub+YwBeoXgeCZDKQPx5eCgS+jhHZWpkkKSdp/I1WrOE8Nh5kBLZd+
         lbugiQ8EYOvt35Hcb7M9iRDbBBgUyWOSNdKzWkjgEcb6BOhUsV3G95XTSktWIqAbFSbV
         L4Npm93rGcp4jzf+lSOCepLUTDjb+zPOl4ZdXX8rdyHPTUqMFOwoW3Sv3JElgbFg4Em0
         yy5Ho6B//1yJnFXQdUl/XDoShd/xUy+dwADfDPZjJ3V9wIWH1bcZqgUsPw94OJ+W7lNi
         uX0Q==
X-Gm-Message-State: AAQBX9dJnkRHtjgw2FVPe/Fya2teSwbI0xjDy9VukTr4XtwX1iE6Mrwq
        QO7U0E/eibwVUE6VQ4iFd36EV07aDIhwDhGawTFm+LjDsIot2QcoNO6X9wHMIL4XQqbgzc3Dr3H
        1m9j/3qdgKJ3J3P/sJFfyU+pyY/hGuYgnh+p2qWeC3KEDLVK64BDXag==
X-Received: by 2002:a17:90b:50b:b0:23d:2de7:717d with SMTP id r11-20020a17090b050b00b0023d2de7717dmr3600029pjz.0.1679942912057;
        Mon, 27 Mar 2023 11:48:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350YiS+T59YyZlkclHjDqBjphDDrNW6NTzBknHvI9nqgi4kpH9PCxmFSrUWgrApFshRLUArK/k1eGfgORrG48oAQ=
X-Received: by 2002:a17:90b:50b:b0:23d:2de7:717d with SMTP id
 r11-20020a17090b050b00b0023d2de7717dmr3600027pjz.0.1679942911716; Mon, 27 Mar
 2023 11:48:31 -0700 (PDT)
MIME-Version: 1.0
From:   Matt Zagrabelny <mzagrabe@d.umn.edu>
Date:   Mon, 27 Mar 2023 13:48:20 -0500
Message-ID: <CAOLfK3WuXuVKxH4dsXGGynwkMAM7Gd14mmxiT2CFYEOFbVuCQw@mail.gmail.com>
Subject: subvolumes as partitions and mount options
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings,

I have a root partition btrfs file system.

I need to have /tmp, /var, /var/tmp, /var/log, and other directories
under separate partitions so that certain mount options can be set for
those partitions/directories.

I'm testing out a subvolume mount with the subvolume /subv_content
mounted at /subv_mnt.

For instance, the noexec mount option can be circumvented:
root@ziti:/# findmnt --kernel /subv_mnt
TARGET    SOURCE                                FSTYPE OPTIONS
/subv_mnt /dev/nvme0n1p2[/@rootfs/subv_content] btrfs
rw,nosuid,nodev,noexec,relatime,ssd,space_cache=v2,subvolid=257,subvol=/@rootfs/subv_content

root@ziti:/# echo '#!/usr/bin/bash' > /subv_mnt/foo ; echo 'echo foo'
>> /subv_mnt/foo ; chmod 0755 /subv_mnt/foo
root@ziti:/# /subv_mnt/foo
bash: /subv_mnt/foo: Permission denied
root@ziti:/# /subv_content/foo
foo
root@ziti:/#

Am I missing some mechanism to restrict subvolume with mount options
that cannot be worked around by accessing the files in the subvolume
as opposed to the mount point?

Thanks for any help!

-m
