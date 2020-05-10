Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885291CCC6A
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 May 2020 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgEJQwF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgEJQwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 12:52:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2388BC061A0C
        for <linux-btrfs@vger.kernel.org>; Sun, 10 May 2020 09:52:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g13so7926199wrb.8
        for <linux-btrfs@vger.kernel.org>; Sun, 10 May 2020 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=anlZWCKm9k+ii/ucxEDKnqKYqjV7i4yqzIScGeZau6E=;
        b=kUjI/j4kyCPtlX7nHLIM9aAb8kWLc5h2cYYIO4oVSR+Ik44484jQ70ZPzeW8F0KVz8
         pw2BLhSnrfDvUwjqkTq1ZE4l0btg1msndSHu4u4U6Xue783R/wEm9sEO6FW3AtFT5JgV
         it1Jhwm4s76Us8nqO1JQrb6Gr5rL54ZqIJfORffA3B3wHnoxm0bJpxzv6F+joFJ8l7eo
         QCstogWwHyQ1Wz4e+w1qx1UBYjLGVwE4e/XghTaldc21YonHBZd4P4z/UBknrYpYydmk
         abIfsVq+cNHEw3IBaXinh0o7dlYk/sNW07F11Tk4DU+NxcOuPUNftvmzwdlQy2c+nzKz
         d1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=anlZWCKm9k+ii/ucxEDKnqKYqjV7i4yqzIScGeZau6E=;
        b=U/iE/ITDIyys6KE4E6Pqdoq9I3iHdGkAQ8i0wMf2LeXQtnt8M6gdNwg5KujXz6DtvO
         andwolzngnXg3D+5/qVSzSw5KYdw8EVKCOXNY9EgyVhUKxDlemdtqxix2mHD+nENPLEO
         tws2UzqpMX5KcY0T0EatfPn4FohY0sWO+RkNYHJ6BFzqoZLuYAoZTlSin0+jYygid6Ym
         H08sJtCasMgNDFKUSj9hVrGrb5kBxIlPOBtN5ZBlZPjCkewXQs2hupgrYy+JbVIBzp7q
         pCoh+So7OatcJXdfmGZBaqE814EcUIzGEfm/DsyWZVm50Qy5V5GaclnDe57PnYe3nFa2
         phbQ==
X-Gm-Message-State: AGi0PuaWtAVh+MWaG3H0psJrFPClCCFUXw+MFr5FDPAimN+u7p124/NA
        rSfaD4PjJghi3W5eiyL5pUjrjmFMxuY=
X-Google-Smtp-Source: APiQypKjEHIS04edZMzdxTNdoxR3k8+ICrOekDF2Jtlhkmmg930Fn3tVxBhEZOEb9+MFeaMa/+O2Vg==
X-Received: by 2002:adf:fa04:: with SMTP id m4mr14066810wrr.30.1589129521331;
        Sun, 10 May 2020 09:52:01 -0700 (PDT)
Received: from [10.0.0.2] (88-117-111-143.adsl.highway.telekom.at. [88.117.111.143])
        by smtp.gmail.com with ESMTPSA id d1sm12700524wrx.65.2020.05.10.09.51.58
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 09:52:00 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Christoph Heinrich <chheinml@gmail.com>
Subject: unmountable filesystem: open_ctree failed
Message-ID: <fbf7d9e2-f64c-4598-2ce4-e1a05a6ede33@gmail.com>
Date:   Sun, 10 May 2020 18:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,



my hard drive can't be mounted anymore.

Two days ago the drive was very slow (<1kb/s read and write, but I didn't find any errors anywhere).

However after unplugging and plugging in again, everything seemed normal again, so I don't know if that's related.



When trying to mount it today I get that error:



mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdb, missing codepage or helper program, or other error.



Mounting without -o results in dmesg:



[14479.650956] BTRFS info (device sdb): disk space caching is enabled

[14479.650963] BTRFS info (device sdb): has skinny extents

[14499.742007] BTRFS error (device sdb): parent transid verify failed on 3437913341952 wanted 7041 found 6628

[14499.753076] BTRFS error (device sdb): parent transid verify failed on 3437913341952 wanted 7041 found 6628

[14499.753089] BTRFS error (device sdb): failed to read block groups: -5

[14499.816157] BTRFS error (device sdb): open_ctree failed



I already tried mounting with usebackuproot,nospace_cache,clear_cache, but that resulted in the same error messages as before.



When running btrfs check I get the output:

parent transid verify failed on 3437913341952 wanted 7041 found 6628

parent transid verify failed on 3437913341952 wanted 7041 found 6628

parent transid verify failed on 3437913341952 wanted 7041 found 6628

Ignoring transid failure

ERROR: child eb corrupted: parent bytenr=3437941538816 item=123 parent level=2 child level=0

ERROR: failed to read block groups: Input/output error

ERROR: cannot open file system



 From what I've read so far, running btrfs-zero-log or btrfs check --repair may help,
but it may also do more damage then good, so I'd rather ask then make the situation worse then it already is.



kernel 5.6.11

btrfs-progs 5.6



Regards,

Christoph
