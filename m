Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB1F3E3A0F
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Aug 2021 13:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhHHL53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Aug 2021 07:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhHHL52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Aug 2021 07:57:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07106C061760
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Aug 2021 04:57:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a8so23530454pjk.4
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Aug 2021 04:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D2+mieY3bULXhxBYhOHH9cxJN5BcoD7z2djMqbu8kx4=;
        b=JDaDEYCxL9i+1WAjUAcfFmPbXwPATX9s3K9FxuUYkLf9fZiMhGLRG5dj+Bk8J/X3RY
         ZfYPAvGQ/poSW4UcUD4RMCIne/iqWJ+Hx+Uqv2SwF8koor3V/G3QZje7tJNwr7xJJqmg
         zbdMXlQl2iYFzSYzNMPQi0feycF/u1z3lHAJ+CKcpFF3/WKTjY4GB9pqNrF3FBuL1LYi
         rozNVJjZ72DmEjO2LWgPS6sVw+ntmm9K3WFH5ftDIjcAlw2Zn9ny9WCBxUThekF83Vfr
         TauQWwVV2cg03Zco02eI0FFy5VKvBps2TS4XPr2CqSydG8N6vdAZMxNB7QhSLRsdUTud
         sWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D2+mieY3bULXhxBYhOHH9cxJN5BcoD7z2djMqbu8kx4=;
        b=Q+MXNnpfZy4FsK6L+WkCPtXHm3drdJ30527SWn6QioEkMtti28Aave4zA0TxIUJnyo
         kOD1UNU/ge3DMm0uo4kBj7NUWaoTIsBgAbcVZkL7tiJw+G7AZIXuN5kYlvDV9uIOl3GO
         thYchqkDfDKuzeGfUpccNdglDxTPQf9P9fhiYwYxpxkOEu48K5e33GNus3SNlfl2LadD
         CM1AQwN81+tvWT//3KISaQuQzRYg9G7f60BA7RL3bx4h03q6M1GcEivh7yOAWjnL+uZK
         VMlQ7ZHgRC0Apqv1sd5686bCltOrZ7P1WPVOErPbV8qCErvDhI3QuBhmDAJ9nRaLfEX3
         qieA==
X-Gm-Message-State: AOAM533tHGHHkDgezp0LS7FOmL+/KalARLrIVqb7wwqTzqoWlK6NSGDO
        h3YgsNyL5BjcLWvQvOeR6+A=
X-Google-Smtp-Source: ABdhPJzN9XjW30TCgI7z21GNqu5IM+7+o2hmxaZpg0DiXxXigbe8FHQyMH9m9RXiE9D+Uah3d9TQTw==
X-Received: by 2002:a17:90b:4c85:: with SMTP id my5mr31118491pjb.196.1628423828408;
        Sun, 08 Aug 2021 04:57:08 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id d31sm19300916pgd.33.2021.08.08.04.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 04:57:08 -0700 (PDT)
Date:   Sun, 8 Aug 2021 11:56:59 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Simple question for newbie developer about qgroup
Message-ID: <20210808115659.GA4081@realwakka>
References: <20210807144736.GA2820@realwakka>
 <d76a7dc1-b8a7-c8a1-5d67-ce148821a3b0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d76a7dc1-b8a7-c8a1-5d67-ce148821a3b0@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 08, 2021 at 06:50:59AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/7 下午10:47, Sidong Yang wrote:
> > I read btrfs kernel source code about qgroup. I want to know about how
> > works adding or deleting qgroups. and I read the function
> > __del_qgroup_relation() in qgroup.c.
> > 
> > This function checks whether dst is parent for src and store the result
> > in variable named found. I think if the checks failed, the function
> > needs to be failed or print warning message at least. Am I right? Or do
> > you have other intentions?
> > 
> 
> User can specify a non-exist parent/child pair, in that case we don't
> need to print error message, as -ENOENT is enough to inform the user.

Hi, Qu.

Thanks for informing me. Now I continue to read the code. 

Thanks,
Sidong
> 
> Thanks,
> Qu
