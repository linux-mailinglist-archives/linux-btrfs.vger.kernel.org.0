Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FE91E3919
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 08:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgE0GZX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 02:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgE0GZW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 02:25:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B514C061A0F
        for <linux-btrfs@vger.kernel.org>; Tue, 26 May 2020 23:25:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j10so7192298wrw.8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 May 2020 23:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DWV7HMmdiSApj+3xD9xWHsPs/R1tW4r+nqNT1zgELTw=;
        b=ZkvgX6Mk01+xjKpcUJowNJB+NjTDV8dtEVhQgoEi6/ekxSLS0R24yuGb2M2gRqz1kc
         3MVo1+hmfyv//OsbUT0sLbJOuGWpNdOkU1pJmTxXWPQDqBetgnFw5jwRBZuGIuPMRUJf
         JtBf/vvQuR9CESYIsJrMuj1+oJ9QhZbb0DRZiUC8XBO3L+JgUPWq9v139R3fyLoHnkyX
         vMO7+ZwZYBrbg3fTWyXBO1bbZjaCQ8RwaVCOgcd3mjz2mUx+GOd5TRjfSTU77ay8uqxB
         QKK5sQQ+T6paeYaA5QKXOnJI6jQ8iTixpmKalqIOLI3zgbZjce3lCWWXqTZV8Tb4u00N
         53VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DWV7HMmdiSApj+3xD9xWHsPs/R1tW4r+nqNT1zgELTw=;
        b=nUu914SRApBebtPo2xRlsMvwrr9B9i/dxgxjwZQ8B+6r8tNlKd5VHp2NzKY9OjccZW
         5nFtwdtUA69CiHRUUcQsGrxqPeWrixhGjKsx0b2KZDG8Bar8hDq2Dg9wp5oAzpfWKeAj
         ScfLSCbIWnAhkSQZLHLJ3KdhOEKX9Dow+PJSg+VOOBR0Eg4lKi1Ju4Opq20ZG0UEKUew
         L0S8nN3VjaTgdd/7VbxqIVyEVdIohvq9o8CPOqkgrY3h1GHRQU1UoPieJFYqHgO0/Jcd
         4jHYkT7gzmF5n9VCPwux8PLIFqYnaWac25M/Rgq3U/FPx32vuEVse7IVNM/KO8PlCBaD
         8X4Q==
X-Gm-Message-State: AOAM531wfU4FUvUWH20o6h9mF5y7AbeJwyJ9HiluI6KH1hln1+oVdqOK
        msUdjbm8Z6G3CXVkargcxcMnB2+c5V7Goy9n1KaEKPOWgKE=
X-Google-Smtp-Source: ABdhPJx8x4fwxWk542ZdHMw3n+LX7rXT0ySg/4uRUyKP4x+MbypqMow5caJ69XItCTNv0j26xvzvsemSHxiVGFRRYP4=
X-Received: by 2002:a5d:5092:: with SMTP id a18mr23112706wrt.42.1590560720167;
 Tue, 26 May 2020 23:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAGAeKut52ymR5WVDTxJgQ=-fZzJ+pU8oVF89p4mBO-eaoAHiKw@mail.gmail.com>
 <CAJCQCtSyJp0LiaO246NcEX-p7rk8-h1NocW4o4rJgN=B1Kwrug@mail.gmail.com> <46fa65a3-137b-3164-0998-12bb996c15ef@gmail.com>
In-Reply-To: <46fa65a3-137b-3164-0998-12bb996c15ef@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 27 May 2020 00:25:04 -0600
Message-ID: <CAJCQCtTmcRfrZEtdnUgF0CkFFWDW-d5-LtM4SFKO4F7Xr9ai_A@mail.gmail.com>
Subject: Re: Planning out new fs. Am I missing anything?
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Justin Engwer <justin@mautobu.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 26, 2020 at 11:22 PM Andrei Borzenkov <arvidjaar@gmail.com> wro=
te:
>
> 27.05.2020 05:20, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >
> > single, dup, raid0, raid1 (all), raid10 are safe and stable.
>
> Until btrfs can reliably detect and automatically handle outdated device
> I would not call any multi-device profiles "safe", at least unconditional=
ly.

I agree.

--=20
Chris Murphy
