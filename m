Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3F17A6C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 14:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCENyL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 08:54:11 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41549 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgCENyL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Mar 2020 08:54:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id b5so5309012qkh.8
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2020 05:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zPXoKiWvKnYYVOFZRxe1CyyL7gay2zdYSa9MnMI6QkI=;
        b=BC/K0PY9T8TS9pT5BAqwZSbBsJFPHsPmv61XqbQwOwxnfjR0jzUIEGOprCvVHDohCF
         g4MESc0EVi+aJbe3rN8bg9VnxEYlwGIj4DVK4EQ5BVaHSUVwoMIc6kJNcJv291WgmKCp
         IgZ5zIJVNklTrU0GhBB7qoG9g8vFpmptHUrf79+xq04KQ9XyIDfFcGOkWd1RBo7uiYAD
         ykKofPmpGVfjhmbaPo1zEcxFEigRiVE+QxkaK503FP3nr6ALV3Qku0uoKdB51i0ZcUV2
         Bj7QtEsc3KVdy8aqsVtSHiq21FvW+vgAjcZCjDz1go6u1PHY9X05QBArFaYKhcq4tfgJ
         bQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zPXoKiWvKnYYVOFZRxe1CyyL7gay2zdYSa9MnMI6QkI=;
        b=TG7NDWF9m3nubfwGBw6KQaaaV4VWvDR2hefC0R/lBbpgj0B7AY0ThN7aICDijHPhqE
         K/9gTsARhA+wb8jWL7XTuMzFGsOLJYLJ+QpYQOd0YPbYnWSIm1mvTj1H0FJ2uDCWSWQD
         kuIlPd13Y23feVl8NqF6oWjmb3ed2bpAIUjg+QK7TVWzzXdykSp0Q09LMknkrRFEpnQu
         f66du20yBOCEUSwdsOZ/dar7dvmnC0OLzNXO/gVg6/G5Eyq0PHdeBH6nYsQeTm+IYJMA
         0fLKRLuo/tCmbA6n4sM+qaHw5xgWEytNp2Tog/pjSA6kpHobigEOOJe/GRGUNvVNuPXJ
         CIMQ==
X-Gm-Message-State: ANhLgQ02smCkgSfcMbAGbINSERJfkB2zASipGsEWSjSBctLcQcCw/9G2
        +xGNLOILup7sbH+FWi/RpXFvJQ==
X-Google-Smtp-Source: ADFU+vtDinFFtePFv5vdg7+CvlG2eKrQaWe7uHETBEC5fVNRUBlXZSU/7TEvX86Dg1hAkgkYWLaYiw==
X-Received: by 2002:a05:620a:148e:: with SMTP id w14mr8299897qkj.473.1583416448999;
        Thu, 05 Mar 2020 05:54:08 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l16sm15369819qkk.118.2020.03.05.05.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 05:54:07 -0800 (PST)
Subject: Re: [PATCH 6/8] btrfs: clear BTRFS_ROOT_DEAD_RELOC_TREE before
 dropping the reloc root
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200304161830.2360-1-josef@toxicpanda.com>
 <20200304161830.2360-7-josef@toxicpanda.com>
 <21e4b656-af48-d10c-c549-11770eba541a@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bf2b64bd-4b16-f4fb-3ef2-19d2b010824e@toxicpanda.com>
Date:   Thu, 5 Mar 2020 08:54:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <21e4b656-af48-d10c-c549-11770eba541a@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/5/20 6:41 AM, Qu Wenruo wrote:
> 
> 
> On 2020/3/5 上午12:18, Josef Bacik wrote:
>> We were doing the clear dance for the reloc root after doing the drop of
>> the reloc root, which means we have a giant window where we could miss
>> having BTRFS_ROOT_DEAD_RELOC_TREE unset and the reloc_root == NULL.
> 
> Still, I can't see the problem where we have BTRFS_ROOT_DEAD_RELOC_TREE
> and reloc_root == NULL.
> 
> IMHO, that would cause anything wrong. Or is there anything I missed?
> 

I was still hitting leaks and I was convinced it was because we were re-init'ing 
the reloc root, but I think that line of reasoning is just wrong.  I'll reword 
the changelog, it's just a cosmetic thing at this point, not a real problem. 
Thanks,

Josef
