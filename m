Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC46A898B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 21:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfIDPbY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 11:31:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32924 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbfIDPbY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 11:31:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so21777475wrr.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNDP5FkW4t0d9CDT1RYgZdJB2++b05QV5TCD4osOxnI=;
        b=WeS4KJNQ2qX88OwmXYJ4EoKNU9ZSu5Xhfr1gB7L9tBkSNPc3SSDEU9lpn+HR0y9yUZ
         gv89NDxAhaQowpVrd+3Sck+KluoGetRodlibxRjJRouK+XKiwZG+5Wtmx/q5T3/9m3qr
         wSQFXxJF95/mRmlLNCFVSCPtmibctPzAa1o/32UJLdGoeZ1VGaqnd8u4NmNTe7gD8hpF
         8ahCqkB+0frXkWt9NwCoCM09xBVc6NDjnJfyHKWDv1USjZmqi8Lr4WIMzDxn3pp/khY+
         t7sOqE6LGpBGy3ZoaDgQEqrPhRA9eMJVkd+xXunzvAleyKBM+oVuFzZdybNahgC04xpE
         +sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNDP5FkW4t0d9CDT1RYgZdJB2++b05QV5TCD4osOxnI=;
        b=jCZeRiHVOzdbp8j96kOocHl0G0RXpcC3F+nYrZXHSiU9g4TxEfTanFv2CwdPZ1E/DH
         iuc3N8vhmEv1Vi+Lzj8GA3l/dWHr4jx4OweLUjgyKe8WZnPYU6iW2y1s+FqmJ+Aum2go
         mUVb41wVEY6BmvB6MGQ0zH1rOomoNwPVnVU9mzSemngvXEhwDhfPlsiceMUU1RyKBftZ
         RPzuGzPcpFfs3dZpUyEfj+3gMcQ1x3/xpBEYH4mZ6yxkWOYWG4sJfzQbE/R+Y9q1aPjR
         f32l74Szrwyd7MoIwmlQGCWnBYe1kWRknV9VUE8hPUSUL8rQ08t8ZvwiBW2bUY8V65f/
         XMcQ==
X-Gm-Message-State: APjAAAUZiDB/uFdk2CBq4agM9OztDwJT9ZIdYetDEnnq/AV3SlZS6H11
        ACHtsY3hz9fVc6brHaQcS69DT9sr79f1ZdlSS81+68j2
X-Google-Smtp-Source: APXvYqz9Dp0Nv/LQcbkrY/iKYSQBVtiYsETgct2YaC/f9RqB10GlcDlqadoOl8n8Y6gcxRH/vpG/nPmDipvF8URcRmo=
X-Received: by 2002:adf:dc03:: with SMTP id t3mr13636994wri.80.1567611082648;
 Wed, 04 Sep 2019 08:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190904081802.8985-1-jthumshirn@suse.de>
In-Reply-To: <20190904081802.8985-1-jthumshirn@suse.de>
From:   Noah Massey <noah.massey@gmail.com>
Date:   Wed, 4 Sep 2019 11:30:46 -0400
Message-ID: <CADfjVriTtGZmhcXRS14gmS27g278zkvpgpUJ8g5VY4m+ryP4kA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs-progs: fix zstd compression test on a kernel
 without ztsd support
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 4, 2019 at 4:19 AM Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
> The test-case 'misc-tests/025-zstd-compression' is failing on a kernel or
> btrfs binary built without zstd compression support.
>
> Check if zstd compression is supported by either the kernel or the btrfs
> binary and if not skip the test-case.
>

s/either/both/; s/or/and/


> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>
> ---
> Changes to v1:
> - Also check $TOP/btrfs not just the kernel for zstd support (Dave)
> ---
>  tests/misc-tests/025-zstd-compression/test.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tests/misc-tests/025-zstd-compression/test.sh b/tests/misc-tests/025-zstd-compression/test.sh
> index 22795d27500e..d967e358fcb2 100755
> --- a/tests/misc-tests/025-zstd-compression/test.sh
> +++ b/tests/misc-tests/025-zstd-compression/test.sh
> @@ -6,6 +6,16 @@ source "$TEST_TOP/common"
>  check_prereq btrfs
>  check_global_prereq md5sum
>
> +if ! [ -f "/sys/fs/btrfs/features/compress_zstd" ]; then
> +       _not_run "kernel does not support zstd compression feature"
> +       exit
> +fi
> +
> +if ! ldd "$TOP/btrfs" | grep -q zstd; then
> +       _not_run "btrfs is not compiled with zstd compression support"
> +       exit
> +fi
> +
>  # Extract the test image
>  image=$(extract_image compress.raw.xz)
>
> --
> 2.16.4
>
