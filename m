Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC55128FA9
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 20:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLVTI5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 14:08:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34165 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfLVTI4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 14:08:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so14425884wrr.1
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2019 11:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qG1F9dGDYe3lYWih8LHQXJme8m4IaN6URgFPQc3ZcM=;
        b=hBmmAwfRvAIp0aSVMwQyIoa+tutPiVYPTOe1HpQREcto8xJb45LWDctHENunlc7+wW
         jXOP+d9BgNIQ0C7cxajEIfFNxoI7pgQWomqr6tgg3i1kHg/eSFovLAHiVA5kdK5BUa1+
         P6kcnETONqzwrQTEz5s1qFh1mxTSl65WD/6NjUvnSGiob8HdTvH+BGk91A3riwcDusES
         8dqSn8ObMo0sjuX2BEaLEr60rdE/MHgMdUEZOccCsxm5euXzWH62ELglXz7aUuUX6xcl
         iL6+max4yMGQmTfsubsK4DSp2prpbzFDQhDlajRrFro0vVj14XeEXIQuBdRAkFMErM0x
         C0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qG1F9dGDYe3lYWih8LHQXJme8m4IaN6URgFPQc3ZcM=;
        b=CiOVRRbdaaZ12p8/+URDWYsUOmOYjdi53F5yTjawA+811DpIcJueSnvVuEmmJzehKO
         jPAKXQQIoxmlO7AxTK/8q11+1FGp9gyZLW0ggPwLdU51RtE7B+34JBVdTnxWbgQHZaJr
         QZzuCGxFlrusu9n79IsP3RD3csEj8hX6sX/MMI8o6n7CkiHFEf+rUC0snFCiYHfrMT/W
         Oh6LmYAc2uSuhYuDVmSiGIoQX5jU3pFyxwbegKa1Zddw31W7zVw4Ftq1BOn+iXE/pqPT
         mpnbytxk9Bx+Jzla5CkwedONPEwF+J6Oo1EFfKwgMCS7wKrUFT5LmvuaoUoLkSxaHtkZ
         ZChQ==
X-Gm-Message-State: APjAAAVPeQSJqrGev+aBl5RP2qwMlLF035vcgWq8DAQ5mOgLrdjEhb7/
        /kokKPl7+Lzdlp/r8Rqu2re0iMyNVYgTIDzXNRGfJrAYn1I=
X-Google-Smtp-Source: APXvYqzgRFCQ64O23pXgJcozk+t+RQok8US14hzQKrmClYCTmZMYiBKI9BjtX/7mzcO9xpr4C3aQc8r8yA7DbphYtP4=
X-Received: by 2002:adf:82f3:: with SMTP id 106mr27275140wrc.69.1577041733909;
 Sun, 22 Dec 2019 11:08:53 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
 <c246f5e9-c9b6-8323-9e2d-26f17051df6a@toxicpanda.com> <a6b6cfde-d5df-b68b-cd57-edccc970ad64@suse.com>
 <5e910a0e-2da8-72a0-fa36-7d48f2454ca4@toxicpanda.com> <a6488349-301f-1071-0d96-4970ca50c3cd@suse.com>
In-Reply-To: <a6488349-301f-1071-0d96-4970ca50c3cd@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 22 Dec 2019 12:08:37 -0700
Message-ID: <CAJCQCtQn1KxDj+Ar0GtjajL2QbpKYN=PBHJKcbYUm6vctWeiKg@mail.gmail.com>
Subject: Re: fstrim is takes a long time on Btrfs and NVMe
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 22, 2019 at 11:06 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> Well, if we rework how fitrim is implemented - e.g. make discards async
> and have some sort of locking to exclude queued extents being allocated
> we can alleviate the problem somewhat.

Is it really helpful to fitrim every single lone 4K block? That's one
extreme. The other extreme is only issuing FITRIM to (Btrfs)
unallocated space, missing a bunch of unused space in block groups. Is
there some happy compromise? How about filtering for a minimum
contiguous range of 1MiB?

And leave online discards for the single lonely 4k block case, with
devices that use queued trim?

My understanding is that any SSD that's suitably well over provisioned
for its intended workload, doesn't need unused block hinting of any
kind. It's really the devices that can exhaust their reserve of erased
cells, resulting in writes that are dog slow, that can effectively
take advantage of trim. But does this class of device really benefit
from every possible unused block being reported by trim to the
firmware? Or is there some sane minimum size, bigger than 4K, that
would be useful to report, and also a lot faster to report?



-- 
Chris Murphy
