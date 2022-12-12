Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE3764A41D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 16:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiLLP1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 10:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiLLP1O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 10:27:14 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BAFDFFB
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 07:27:13 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id r11so11492465oie.13
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 07:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tMdyztU3FVDlA45ucvMuT0sjCecPMUVu8eJolo93cho=;
        b=QpwuxLhDUwTb30SDsQq2YDYBfzkWF9pHqhFL6icK0MXY9vwIRChEVDpqaXd3DjmDuc
         uFkQgEvh9FEMYoM8cMa/1aNHDV5oTn5LpR3buSx3vNjC2vITVSeBEoSIpOS1xgnfbsf5
         iKUFAVwB36v16aXJHE3P6UjIZfO/zeX2yuITCDvBHvEJbkNtrBc0ZOXHox5xgxDoREcK
         u2Fagdo8W3MQjmZ9SGUVqTXJoNTFF1dlxhfoh6XgYOW05PyOiUmWsHM6m/4oZROIpxNF
         5SF1PhzPxicAwP6TtHQ5S2lWIUOiXpGjXQNcXNyvLn7hOBTrxObKJwIKYSLM4V8Uxfdw
         ZBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMdyztU3FVDlA45ucvMuT0sjCecPMUVu8eJolo93cho=;
        b=6p/q5yttg8iZ1ndnx9FhPB3iNHpztL2Y/I8iiyj1quqNXYV5tUhKidK9w/Qngr26IY
         BgILK7IjRXNhbZ3auDPBhRm1bZf232AWln9fq7pNl/tqZKO8aN9E/ELwL7MTvF/ssBzO
         2fOCnuYH3ZiduHBKnj5cm4YvQ5Z4U5L/7ozK5Jeig44Frr/2qTN7lVrSFu+GB6QHl0TQ
         vmcuywpY8L8C+iGDvwvW4weIWZPo28ZK+SMilWBa1VfWzfTcbIujAe/U3dyetcTuni7n
         HNtw6HM5v0r8DvTeAUzN9KvAlIU8V1kjDm2yge/7NmXzaodFxwH50vJkV1PJ1wxYTT9R
         z9kg==
X-Gm-Message-State: ANoB5pk8H/U8+iCFN6kA4lS2PiJrI+V4HZv02Jmx/rsz6G+4heX+HGGO
        dIGROjfsG5V4KnKx5cc0ZClAsWJy8XBEf3T+KT1ILounSgY=
X-Google-Smtp-Source: AA0mqf6BSiFe0db/MO0Q9ju1xe/6m3ZS+aKZSQUFxO/gxzKJXxMbNah66uGnDkhlb5P+IXqQFMNfVGpfGq6PVKjqBQQ=
X-Received: by 2002:a05:6808:1482:b0:359:c6de:916a with SMTP id
 e2-20020a056808148200b00359c6de916amr36672793oiw.42.1670858833062; Mon, 12
 Dec 2022 07:27:13 -0800 (PST)
MIME-Version: 1.0
From:   li zhang <zhanglikernel@gmail.com>
Date:   Mon, 12 Dec 2022 23:27:02 +0800
Message-ID: <CAAa-AGn0r8W1rRAXvdw9JXWcHf22SH-+44zSVwnsQC5wz5464A@mail.gmail.com>
Subject: [Question] The function option of c in subvol/snapshot create, what
 does this option do specifically?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I found that in btrfs-progs subvolume command, when user create
a subvolume with option c, but description of what this option does seems
to be missing in usage and Manual documentation, What behavior does
the file system
take when the user specifies option c, copying the qgroup to the new
subvolume? This means that if
referring to the old qgrouplimit to a Max referenced of 1G, the new
subvolume is also
limited Max referenced to 1G?

Here is the code associated with the c option:
in file cmds/subvolume.c

static int cmd_subvolume_create(const struct cmd_struct *cmd, int
argc, char **argv){
...
case 'c':
res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
if (res) {
retval = res;
goto out;
}
break;
...
res = ioctl(fddst, BTRFS_IOC_SUBVOL_CREATE_V2, &args);
...
}

thanks
Li
