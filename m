Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D15A12F9E7
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 16:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgACPmg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 10:42:36 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37158 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbgACPmf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 10:42:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so34085656qky.4
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 07:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z5OBrN6ZmrGNnuSXVYsD43O/DtdpuRo4xbPRml+vZT0=;
        b=jKyOXThfe+Ch1DuzYRLw/yxan2VquOl1RVxkdv2eGFmLvvugRPhWFLuMNvdS6cS81h
         /rpbk5dtc601rsTIx4HW80Djz4AxxhjhhoXqAUwn6xrbD/YNtOivP4jZ685dLV7o4KXk
         JKr7fY7mFed0PUC9AxtG9wCCVwtOZfAWrKees6Nzmb84TCJTE9PCg4x8fVDre3+oKeQf
         QlxKsdDyQzndMoii93fjsSvhdJCLs5DUOhR77PfJa4Fxl0OnUVwlfIVQ52ZjUmUt8xFv
         TpLa0jT+L6rX04ZbcmfKIXWhLyvH9T9Hy6D4k/qxVBgNV/doeAIVgbkoTdV1Bp85+pvs
         n+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z5OBrN6ZmrGNnuSXVYsD43O/DtdpuRo4xbPRml+vZT0=;
        b=KlTiNvcc8bXbL4ko4wKkbbL4M0ddF+H8y2tPqmAH+tfxZP93FvoCZlFiMOtvZGfbYq
         MEMvlmlSCYC4n6hIVZDTpQjig+Wpnn+gh3UiW5FTvLVdJx+SjFcX+3tBS31uBcSOYmCa
         AOyKBEVj+YY0SAyBWKtL48B+v3SWVfmQ2rSpNGMSsimdMQkJuTq+tddC4TGkamUcwV/r
         zmwfERNtMalDQ7V0+ZTKXoWhN2JjfBwAt4eofLA3/we9xlO/cfyAvGOQiO+T++8xP3mZ
         2HUxeTNywy0nHzmsopRLoIsFKxIG87rA+YX4m12NJW5Tv3ZtFPTVJPh3gZiZHJvr3vQG
         xDMw==
X-Gm-Message-State: APjAAAWaXGbVJnIHzxSTmSIuej37o/I/KNaYiNg/UPez+yEWXvrg6nsM
        P0cXde9Ya/upTauF5DRB+4D/2rRwti3mDA==
X-Google-Smtp-Source: APXvYqzISCPUj324y+DKnjnOwsXNduRzWhK1Dbc9qwI+ySs4g59VHyJg2GRWAK+/lTTZ0RsTdwONkg==
X-Received: by 2002:ae9:f106:: with SMTP id k6mr73953628qkg.189.1578066154739;
        Fri, 03 Jan 2020 07:42:34 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q35sm18737004qta.19.2020.01.03.07.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 07:42:34 -0800 (PST)
Subject: Re: [PATCH] btrfs/140: use proper helpers to get devid and physical
 offset for corruption
To:     Johannes Thumshirn <jth@kernel.org>, Eryu Guan <guaneryu@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20200103111810.658-1-jth@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2970a67b-c10b-0038-ef2e-29b42dda107d@toxicpanda.com>
Date:   Fri, 3 Jan 2020 10:42:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103111810.658-1-jth@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/3/20 6:18 AM, Johannes Thumshirn wrote:
> Similar to fstests commit 1a27bf14ef8b "btrfs/14[23]: Use proper help to
> get both devid and physical offset for corruption." btrfs/140 needs the
> same treatment to pass with updated btrfs-progs.
> 
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
