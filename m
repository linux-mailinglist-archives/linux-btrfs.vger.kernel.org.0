Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C922E31C3
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Dec 2020 17:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgL0QI2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Dec 2020 11:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL0QI2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Dec 2020 11:08:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8041CC061794
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Dec 2020 08:07:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y17so8383586wrr.10
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Dec 2020 08:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=L9mRioyP8ZeCnk8sh8FbA1gprsldyWwOmtlmteWtTgs=;
        b=UwJyb5KHaiIKw4KfC8l3mqN2iloROFppo+JLu9MS3KCMse1P93sVKpCAAlO+jqaqfQ
         femNtCPfpF6tSl2OHX1tUzk8inp/ju1+OSSVKiXaJOtGEoHu+T6DGdx6UjYFkkTLISxd
         DDGtNDpyABx4vX4sK/D17qxFcfpGvDP9n88Jwiy4E9GlVJz5PNepTGqpJ9MaEEZvOGky
         E3bqjERIicLHcX80t6IOQCqiilTtnC4OtS3UVvsA2K1mpvb9w9BWyfdpDHRcTPKfMdow
         thacGBIgeqFHCk63ObV2KOYGImbzw0nkjDhqgauAa9nGLXUioM4kdc86GCXy/aXogZb9
         kvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=L9mRioyP8ZeCnk8sh8FbA1gprsldyWwOmtlmteWtTgs=;
        b=VM4slODADn4XtmutNDZN3Tzfu2dg/d4Ow5JLkABbWVArwK4OCDV4mE1F29QFmP/NGy
         OvFDbKPKVuRKfmKWy/uScjmlMNp0BE8Cv9vC3BigxAEz+RfSSgsFRVHWVW6dW0EUWICj
         t5On4AaO1+SXJz9Z55rAJkGMFN1Do0HtMZO4Au3VoNzWmoIgT5bsfqoRnuLMUcJDjHrW
         rZseztAIvPT51HDjqcMZ5MfO2d7+IJwGqz8oHGDvFA+sgQGERK0GMe2w+yNpXmNwqoYP
         GTLGIKEFBv/uBfY2vtDQhz2gv+B7WE3niYRozUQA0ghQorusvbsnyZn6BB4ACeHoJgaH
         N1LQ==
X-Gm-Message-State: AOAM530YkPJdTfE24AjjbdOti15112SrFsZKX5BDcOtgmmVzIdVegGTz
        +dh9vICfWuVauTubqgzazscKU35KAWYlZQ==
X-Google-Smtp-Source: ABdhPJybrfDvsR1Z4xAA9sU6HHTwcyDlsoakNm1vaXlNFP+xQ+U4rQQd0Rud7h2a8tLd4O/Tb0M08g==
X-Received: by 2002:adf:d085:: with SMTP id y5mr48463057wrh.41.1609085265878;
        Sun, 27 Dec 2020 08:07:45 -0800 (PST)
Received: from ?IPv6:2a02:8010:64ea:0:fad1:11ff:fead:57db? ([2a02:8010:64ea:0:fad1:11ff:fead:57db])
        by smtp.googlemail.com with ESMTPSA id a14sm50811765wrn.3.2020.12.27.08.07.45
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 08:07:45 -0800 (PST)
Sender: Mark Harmstone <mark.harmstone@gmail.com>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Mark Harmstone <mark@harmstone.com>
Subject: Per-subvol compat flags?
Message-ID: <805c2fd3-d62b-2d0f-0f3d-c275609bd1b5@harmstone.com>
Date:   Sun, 27 Dec 2020 16:07:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I'm the creator of the Windows Btrfs driver. During the course of development,
it's become apparent that for 100% compatibility with NTFS there'd need to be
some minor changes to the disk format. Examples: Windows' LZNT1 compression
scheme, Windows' encryption scheme, case-sensitivity, arbitrary-length xattrs.

I'm loathe to nab a compat flag bit for these, as they're all relatively minor,
and most wouldn't be that useful for Linux. And sod's law says that if I
unilaterally grab the next bit, the Linux driver will sooner or later use the
same bit for something else.

Has anyone ever brought up the idea of per-subvol compat flags? The idea is that
if a new feature affects the FS root and nothing else, rather than adding a new
compat flag bit, there'd be an entry in the root tree after the ROOT_ITEM, e.g.

    (0x100, 0x85, 0x2ed1c081232d)   for a compat entry, or
    (0x100, 0x86, 0x85f7583bc4b0)   for a readonly compat entry

With the third number being an arbitrary identifier for the feature (i.e. like
a UUID). If the driver doesn't understand a certain feature, it'd make the
subvol readonly or inaccessible, as appropriate. It'd also have to disable
certain features, such as balancing, but the rest of the FS would be usable.

As I see it, there's several advantages to this approach:

* Because the feature identifier is a 64-bit integer rather than a bit, it
  increases the effective compat flag namespace from 64 bits to 2^64.

* It makes out-of-tree development a lot easier, as the increased namespace
  makes it feasible to distribute patches without worrying about what's
  going to happen upstream.

* It lowers the cost of implementing new features (i.e., you don't have to
  let users know that new filesystems will only work on Linux 5.x). This would
  be especially important for encryption, as security means that you'd have to
  make it easy to add new algorithms when necessary.

* It allows for features to be controlled by Linux CONFIG flags, meaning that
  e.g. embedded devices wouldn't be burdened with a new feature for all time.

Does anybody have any thoughts?

Mark

