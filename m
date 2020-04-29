Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2127F1BE76E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgD2TdT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 15:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2TdT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 15:33:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35111C03C1AE
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 12:33:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s10so4011288wrr.0
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfqliozY8baqe2sJDsUsETSonaJLPxX6up4Kei2Hbx8=;
        b=JdBua0nqXQq7ojZdA3vJFQ1epinGfLiF/cv9LtjsaTR0vYisDO2CZgbmGvYbTiV0KY
         UPx5U/zeUy0VxmZ4wMtlgjb4d1xiuMJ3y6/zKqGaeSYDNYui6/uqnADsF85rLhI3W1CQ
         5KMqDbA4q4TsgljVjkBb2mdJDLhV9XUcmgMF6+4WNiLwVUTGJRlbzrDK/IsmY1s8EM5H
         A8v/2ZNsI5qGjVzHQXMFhQFMLjDl3Z8gLy45AHuMZm6aRt1xaPDo8b0/nXVOCvOomKMN
         062s0IOTYwxj38/VqBKTzLvfkJBshIbFPE+21Q17fxnx+h04RuIK4PPaaWqvC22LAldY
         IgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfqliozY8baqe2sJDsUsETSonaJLPxX6up4Kei2Hbx8=;
        b=tT/e9X3CQMuqwWo0Asv1pT8A3GkGD22vwjs+XHV8h9Bhijt0UnpHQ/OyC8o0DYZVRh
         w4uZAuTU+SgykOPUSXQ8sweApF50Al0a3hilAEx3dqSkQ/6OD5TG1XTzOxqmSKb8tfNO
         YKTeRheUXhpJAFmGeCXXo9ZrRUxHxRf5xeu8DjdgUOFlBhXxlF0jKccz7GZud2kGADf6
         ZzYGubgApQoUDu7sX0aHbgGuHzTNNo7zz4yynYwVwSVXKWl2H61KHl1GT1LICLs/g1X1
         Nx9yr4SM47OXvg23NxGRY/y9eLnHYrL+WO5coeKlnuRzEJeIlVUNN285o1LTt7IH05P0
         ioEg==
X-Gm-Message-State: AGi0PuZDN0GJZU5IgPa+D+RCQ0262Q+jgnz/iBIbBRCepq4nFkT5SVEI
        uE245H17aXMozP/Z9fCa8cb+GAXoKhV3plZhY452STLW58U=
X-Google-Smtp-Source: APiQypJ3EOWkrx2vPZgB27ybE5G/ERAN8fKLhR3XB7AfwH2m3UMqQvAg352qF3oRnRLgILdEcpS+ak/zVmeA35YKRAc=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr40886766wrc.42.1588188797913;
 Wed, 29 Apr 2020 12:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <f2e0ca56-c059-978a-2d47-73204b22945b@peter-speer.de>
In-Reply-To: <f2e0ca56-c059-978a-2d47-73204b22945b@peter-speer.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 29 Apr 2020 13:33:01 -0600
Message-ID: <CAJCQCtR7LgAp3QsXwrF9xQdUoiScJkuEsZpavOwwSLvFdEgO2A@mail.gmail.com>
Subject: Re: nodatacow questions
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 29, 2020 at 12:30 PM Stefanie Leisestreichler
<stefanie.leisestreichler@peter-speer.de> wrote:
>
> Hi.
>  From the chattr man page:
> A file with the 'C' attribute set will not be subject to copy-on-write
> updates. This flag is only supported on file systems which perform
> copy-on-write. (Note: For btrfs, the 'C' flag should be set on new or
> empty files. If it is set on a file which already has data blocks, it is
> undefined when the blocks assigned to the file will be fully stable. If
> the 'C' flag is set on a directory, it will have no effect on the
> directory, but new files created in that directory will have the No_COW
> attribute set.)
>
> Question 1)
> If /var/lib/mysql is a own subvolume and chattr +C /var/lib/mysql is set
> and mysql is configured to use one directory for every database, will
> nodatacow apply for a new dir which is created when a new db is created?
> Just asking, because the last sentence of the man above which states
> "...new files created in that directory...". Is a dir a file in the
> context of chattr?

Yes.

$ btrfs sub create haha
Create subvolume './haha'
$ chattr +C haha
$ mkdir haha/test
$ lsattr haha
---------------C---- haha/test
$

>
> Question 2)
> I guess CoW will still happen, if I hold a snapshot of the subvolume
> which will be mounted to /var/lib/mysql. Is this correct?

Yes, initial changes will COW to new extents, subsequent changes for
changed extents are nocow until there's another snapshot.


> Question 3)
> How to solve this and avoid defragmentation if my assumption in 2) is
> correct?

I'm not sure what the problem is you want solved. I'm not certain the
behavior is identical on XFS but I expect that reflink copy of a
database file on XFS causes any initial changed extent to be COW and
subsequent changes to the same extent to be an overwrite.


-- 
Chris Murphy
