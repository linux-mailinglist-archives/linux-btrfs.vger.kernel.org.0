Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAE334800D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Mar 2021 19:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbhCXSKI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Mar 2021 14:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbhCXSJl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Mar 2021 14:09:41 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003A4C061763
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Mar 2021 11:09:40 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q3so18972043qkq.12
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Mar 2021 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rd7lpdHzocW3Iw5e+vbChvxEj7ADC9f2TVRjUvHhkao=;
        b=av0fKO4LpBdOa1uE3I9Jlc+Cxh1L9X6B1EA7PFaIEomBGF1YglFQaJWcgE2UulCmgk
         KkdX1S1u9V3d9FtfZ2vZge3G4g/UQ5YG+UXzzA4FQQZVNAZpdTs+8FYsbO6UQfzgE+Zz
         NVmOOYGW1dw14VHBfDFMV/nMUXracuI4gBrVXDg0Lz/4y5uOlqMVXNO4MJsivDTuIBSt
         nMNoUknVAP4p6K3dXtMzMafDbs6LBOv91YB7H2tXcRW7f3fkCFW0aCImKcHIKXBSnVpO
         z6AOiP84C7CSz+Twj9byWwFwBTvuwgyWvNchzu7Pab2KQfrZ6WZJqka5YRKootLIyokC
         VHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rd7lpdHzocW3Iw5e+vbChvxEj7ADC9f2TVRjUvHhkao=;
        b=sMQqmziU9f90DtwZhEfEIFbeOkHOEXGYCIrgF1TlzhS/DCb1FJpyhzTT8n7QBBgHBs
         2f9F2iMleUMLQHfT18ypeigx+y8i2otQLOROsWIsYHURUui5mUFe+X97RxOnIZ8fPNZK
         M16AS/eCKqQIbTa3jyfOCSpK0+YmCo3nqyrOqluKlL6yArLhkurmlU4weFEMyX5ovX1F
         vkfgqiAwA2goY1utZEeqWYpbsPB1rRo77UGdugNcfT9j7kowGte29v/NHZ7A3T/bf4dk
         JbPt5yF1ICq4fKNdlzRdzWI4suwDibZw+fUX06b5xnXZ/Sv9+H8DDrI5sJlrSzL7TzfP
         lMZw==
X-Gm-Message-State: AOAM530NoO9BDVzQdUnM1owckboB5dDo+k+xI1WYlcTRJf9xOcdBn2AZ
        wrHv9apAZxhRnrmTkh39dDUj3SmxXzDnYe0DpMGqwUzsbP8=
X-Google-Smtp-Source: ABdhPJxX4VQ8XfNqHNrF1lYUUkSqHOX8dKjvl1XcjG9Iz16DuDMko8mCZqKkXekAXlEedlPqnuLoQ7j5qJSSPHJZcHY=
X-Received: by 2002:a05:620a:6c1:: with SMTP id 1mr4558537qky.198.1616609380232;
 Wed, 24 Mar 2021 11:09:40 -0700 (PDT)
MIME-Version: 1.0
From:   Jim Geo <dim.geo@gmail.com>
Date:   Wed, 24 Mar 2021 20:09:29 +0200
Message-ID: <CAD9MmSd+Nt3OWA-A2TWZ3hBmDOo0D8YMSk4HWwnJpEhpUVzYjw@mail.gmail.com>
Subject: thread_pool
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Could you please elaborate on the relation between thread_pool and
physical devices?

By default thread_pool is scaling with the number of CPUs. Does the
default value make sense in cases where the physical devices are fewer
than the CPUs? For HDD? For SSD?

What is the relation between user processes-> thread_pool-> io
scheduler -> physical devices?

Does it make sense to try to optimize thread_pool value?
Man page is very vague on the effect of this parameter.

Best Regards,
Jim
