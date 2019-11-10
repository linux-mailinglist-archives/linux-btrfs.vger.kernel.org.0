Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9965F6204
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 02:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfKJBPA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Nov 2019 20:15:00 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39142 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfKJBPA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Nov 2019 20:15:00 -0500
Received: by mail-wm1-f41.google.com with SMTP id t26so9848986wmi.4
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Nov 2019 17:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rUYWODo4U6nsvtt9DFnG6tEvz0FHNJ+Mq1I1Zfv/yTQ=;
        b=hEVq1l95Y/I13wcBh4rimgwbITgMQEmIby3ilfp8vbs2Qjr4mujsDv+9EWB2JHIIDp
         cWKSHflax9QUfbC6CapSPA88L3/KDxXQzTJ2Iyj2M6jjsKKT55ZKT8E9ya2msQnIHB3f
         K2jBXqjjFYJ1glXaO9pVh36U46ZqYgAwsOX25OTG8nwCixl8uA60ugAEpyWwUPQ/JiK6
         47Ee9po5sUA4+dCazW9frot27pTT0/IEWK65uNQzur44G63KGZTpbVQgqtubrla+1v9Y
         JPiI8LAT03/zljyIxWPsacQ0LgrOROd5poQTkO6le01rMER+K1HZ3gEaiC+KDx1UfQab
         PGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rUYWODo4U6nsvtt9DFnG6tEvz0FHNJ+Mq1I1Zfv/yTQ=;
        b=JdfsB54Ejmncrxy9kwZMbrw/efBbMPE4mACGRAieqtuPEcKP/KhXSCmncCDgQ3x08n
         bE1wWnkhSct12SjdgJE//9BqkRYpMLauB0Y7fB79joXmFV5gcy4LALEcMEl1f4MNi57j
         vXY/t5EgYoSC2SqMbcUdDSHP0XughYCKkq0lBo5JnwmGekKsLVjDlGlfncSDRzPjh+m3
         gKzW/K+3cpEPWcutj6VqVAq0G+OvNs/zpgIJZCx0zTO5JVIdncewBTmptctniPR1obiu
         lqI41vPmn2QZtHQGmBdcXBpEsZ2AEQh3id2rQ05rBhTrGXP9KqYz14mOWHJu3bGHzRX7
         vH0g==
X-Gm-Message-State: APjAAAVpe0odjIqie+gWRtHWyOUJV/nxK7mnO+t16fY5G3NdgcG2Vj72
        om8k7DLYXE7YexuF2Ssi7DUmNuxvXU8VzoaYWeUskx8iDto=
X-Google-Smtp-Source: APXvYqwVVREAsUb7zat59Q7QEnhGQGGVjk4h+NZKj92uYxefn5rICvIS3GZzIHdIpXG7aLAznNcsWLdSCKUWeLZkOKc=
X-Received: by 2002:a1c:30b:: with SMTP id 11mr13526709wmd.171.1573348498503;
 Sat, 09 Nov 2019 17:14:58 -0800 (PST)
MIME-Version: 1.0
From:   Alex Powell <alexj.powellalt@googlemail.com>
Date:   Sun, 10 Nov 2019 11:44:36 +1030
Message-ID: <CAKGv6CrZ6bpMFtWJ5grJ8tsuV1GehEP07QaAmyZWkhj-ixTchw@mail.gmail.com>
Subject: Unable to delete device
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,
I had a disk fail on my BTRFS RAID5 array. It is still mounting but
there are bad sectors which will switch the array to read only mode
when used.

I used "btrfs device delete /dev/sdd /mnt/data" to remove it from the
array. However it seems that it is only partially removing it from the
array and when it gets to the bad sectors it fails.

localhost ~ # btrfs device delete /dev/sdd /mnt/data
ERROR: error removing device '/dev/sdd': Input/output error

What is best practice for removing the drive from the array in this situation?

Kind Regards,
Alex Powell
