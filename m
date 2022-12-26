Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507A465610B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 09:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiLZIP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Dec 2022 03:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiLZIP4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Dec 2022 03:15:56 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241352F8;
        Mon, 26 Dec 2022 00:15:54 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id pe2so4976301qkn.1;
        Mon, 26 Dec 2022 00:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VYpnhqTY2MY5F2Ka3nlaURU6D4qBmSPJKfQx12SNiG0=;
        b=OJp3Z5P6Oxo5iW3vZ+Pvlqqky/1tbudu94KlfWsHnaS7oeB/v9eO2LtnwFwORH66gZ
         TlRaU1hE0HwDsEUdqVA6X2iOeF4hBwglOwhPGRJslDiXJbnlMs76h5Ngw3msOs9YAqzp
         ujeG71QoEilohIdLH9xuUezla/wgph9slzZlTQORlv662LmRIe+QPkW4WUqlTd5fp2G3
         jyvFd8iwKXGzgLjA3WMPDOw0Mk1aJfXOKC51Gg1iCBd9C15LxGVSCHNocr3miqXSAz2l
         9HSzcb9rERTCs38Mq0vmX+ajRXCxhTJhoQGWVVvxhSS/FoiNmqtuSC2Iac0sErwBR2bt
         mgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYpnhqTY2MY5F2Ka3nlaURU6D4qBmSPJKfQx12SNiG0=;
        b=jI1k8UkerR+M30El7Ga2NTmsw32w2rh9v+SPl3YlVs2KBVye1oDVnfgM+Bhlc0WwBn
         teJeQS8Yj3QoQ+uG3laADodq6brRwSbxQBWFb9NgzJVa91ubq9+CysvIWa3IGQSj8L2Z
         A9n4+AAtmh98aW3xAiHv0l9BcJSjGq6RcZ/rpGQH272nCJeXKRRg++9JF37iSe6IXGrV
         hfSmGPFq5GmkgeRiENTjirQJQkXyfBzUxk8YPnqu1matgiHjIz8gjC4lzbOvnl4faxwE
         jDY1I29pPp8jbwuUzemasrZZ9j6Zzw47HJoIHcVQ4irSzlZCJt/fNl3ZgVwNeXYh0DvY
         gn6g==
X-Gm-Message-State: AFqh2kouii8WcNYLiFwKD5dWrn4zlLHYC0bm1RX0Ols4hDkM60mw211q
        sX2ZVWm0EJZ142B/wgUFOiMciI+hFHfUT7fIN5g=
X-Google-Smtp-Source: AMrXdXsW7bqsQkq+u8cxtwEvvUpSjgw277fgBZNCKJqiSBCuygmFFzRqY2BxbfYq59VDrXUJIBLnOv2GN9Ev86AUaC0=
X-Received: by 2002:a05:620a:8126:b0:702:be9:9915 with SMTP id
 os38-20020a05620a812600b007020be99915mr1030013qkn.400.1672042552343; Mon, 26
 Dec 2022 00:15:52 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <f68699c3-ec5e-d8e8-f101-6e9a7020ac81@gmx.com> <CABXGCsNrm3ddn3p_ECSRe+yQeoF3KojTFvy-CpXNzi9ADkbnvQ@mail.gmail.com>
 <18b5fa1e-7d1e-4560-c98b-d7ac5fc87c3a@gmx.com>
In-Reply-To: <18b5fa1e-7d1e-4560-c98b-d7ac5fc87c3a@gmx.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 26 Dec 2022 13:15:41 +0500
Message-ID: <CABXGCsM5y6m=pLX7tyE-RB1yuHEgZh3fxDu5ESfTRxEnW+djZA@mail.gmail.com>
Subject: Re: [6.2][regression] after commit 947a629988f191807d2d22ba63ae18259bb645c5
 btrfs volume periodical forced switch to readonly after a lot of disk writes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     wqu@suse.com, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Mon, Dec 26, 2022 at 8:29 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
> OK, indeed a level mismatch.
>
>  From the remaining lines, it shows we're failing at
> do_free_extent_accounting(), which failed at the btrfs_del_csums().
>
> And inside btrfs_del_csums(), what we do are all regular btree
> operations, thus the tree level check should work without problem.
>
> Thus it seems to be a corrupted csum tree.

Do I need to debug anything else to understand the cause of the error?
Thanks.

> Could you please run "btrfs check --readonly" from a liveCD?
> There are tons of possible false alerts if ran on a RW mounted fs.
>

# btrfs check --readonly /dev/nvme0n1p3
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p3
UUID: 40e0b5d2-df54-46e0-b6f4-2f868296271d
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 6828416307200 bytes used, no error found
total csum bytes: 6651838248
total tree bytes: 16378380288
total fs tree bytes: 7483179008
total extent tree bytes: 1228210176
btree space waste bytes: 2413299694
file data blocks allocated: 6899999100928
 referenced 7488299450368
[root@localhost-live ~]#

With liveCD looks like all OK (no errors found).

-- 
Best Regards,
Mike Gavrilov.
