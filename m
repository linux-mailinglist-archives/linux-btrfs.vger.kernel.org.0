Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40484288ACE
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 16:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbgJIOZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 10:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbgJIOZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 10:25:56 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFBAC0613D5
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 07:25:55 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id s17so4818174qvr.11
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gq/95wHEAbb8vVeFA1Yih6hvdvuJmRbkKfn1VgNnJcw=;
        b=leGAviemiAkJvxErSepR2q5vcMdh4tVIgmabacrqfAPPz0h3Z/f929q84M5i2EOu+r
         fBcmGiDnfZvW8cmWt+a5743IM91Y0ZqU4Uo0udEmZ+Jy9LxAox5cNxXb0k27U8DvLiss
         I5EKTwQRKErctnk11le8wtD7eUYEhzD8e7iNONh5FdTouagex9+oe037gVE+tUWNMDZ1
         2GnwakpZ04wsA4BOROOvJ7CIuccDn6yI07XMsGbS+OfpRpHW0bVGeiPFQOOCKEQStUa3
         YOYENyrWGJwJ9k5aqI7+wqM138+TmgOqcEjh7sP13VcnLGvUM+i6ql/LfNiphPL4CrAA
         w70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gq/95wHEAbb8vVeFA1Yih6hvdvuJmRbkKfn1VgNnJcw=;
        b=djL69nuezQX5AJE96/v01Hi36WvPFP0p/9VK26CYw7/8eUXl7+VV+T6pjyKGAkGXJo
         V7q2KnaeXRdRB1qa9hA/1kglTGDnSl9ygXcJZ56yis8MHhZHmWmatDC0b05wvz0vZPSe
         K1WQUrmzho3Iw7y9fgPU+0et9QXRRVn6YKybcTtxRhoWTupSupvFC7u7g+8b60vqX+xL
         szInbyLqQRwlE3T6OcwTbQWVbuIdQzZf5lBXTnjfsLXyOIIw9vN9nn6oIxgdPb0ZSLC6
         H1ay/K9kfdPtf59oMKtM8huegoVamXnP4mUGmIPAeVkA/2X4I8eLaZyVp/jMVjoE0F9w
         nb0g==
X-Gm-Message-State: AOAM530cJiuk5JkhKF1tS9kX7bSEzlgTxil6Teb5FltotuUP1JZuNeBV
        mWQ/2ohsjUStTnSmOt4cs7727Q==
X-Google-Smtp-Source: ABdhPJxXyAmLiFmH2ALdIfzFBCExokZjrgIVd0BTjBCwQga20u4fZ4AdGU1Jk75fYlrtEMGJd05xfg==
X-Received: by 2002:a0c:b31c:: with SMTP id s28mr13209088qve.17.1602253554281;
        Fri, 09 Oct 2020 07:25:54 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::107d? ([2620:10d:c091:480::1:f1f8])
        by smtp.gmail.com with ESMTPSA id d78sm5936888qke.83.2020.10.09.07.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 07:25:53 -0700 (PDT)
Subject: Re: [PATCH 11/14] btrfs: Use inode_lock_shared() for direct writes
 within EOF
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
 <20200924163922.2547-12-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3a3ba06b-4b18-dced-6268-a33d7d1b7cfb@toxicpanda.com>
Date:   Fri, 9 Oct 2020 10:25:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200924163922.2547-12-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/24/20 12:39 PM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Direct writes within EOF are safe to be performed with inode shared lock
> to improve parallelization with other direct writes or reads because EOF
> is not changed and there is no race with truncate().
> 
> Direct reads are already performed under shared inode lock.
> 
> This patch is precursor to removing btrfs_inode->dio_sem.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
