Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0528130E82
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 09:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgAFIQz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 03:16:55 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38206 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFIQz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 03:16:55 -0500
Received: by mail-pj1-f67.google.com with SMTP id l35so7469934pje.3;
        Mon, 06 Jan 2020 00:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o2l9/alDuzrPmIULbxtnmIOI1g1WS53LksYUGyc887E=;
        b=VI340YGoNYtAb1hiVuK+ItSmzcAga1ko2IL9CKZBfZbKYKwrhyhRyHDhC0U3HvzCj1
         oqj/CZDixz7Zgugpze5yg51DzcjilSV2AYLERUIJPWDkFuSCtWypYn+YQYU7LTTtgno1
         xvv5gvsPE0Vj6VI/tK5lJWMesoCfMmmYYolVLRoDsZmWAridr5mkaI1xeQaNVKgSj2em
         inlLch2yYFDb4q4+sQKrAnV1nWDkwPaDH7KNr7zQ0XmIIyqJyV+yI7k4XIlJlUYQPybz
         AJ6P6eSfnucM2cfOV+LFzbCOCRROTO79E2rnLvm3o1MoRpzagl6ngpXF0FMUTBiUdtjm
         R0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o2l9/alDuzrPmIULbxtnmIOI1g1WS53LksYUGyc887E=;
        b=igrpK3nDl38bYWcUG2DgI+159Sa6MSZXoYZQuQf4PHr84m1RgwAPKW8v0tRbXiuZpu
         yZ7SuZz6WnwaLFYAsKxIwPzk9SngUOGwnTM9i3htJxXROsXkgv9tKDb11P3zqOVlPJGU
         Wa+4AR2Tlun2Av6cO/LwKMAwTxkCfy2VZewPHt4OltSOeyw7Mqi5msscp9wqk7pE3A0r
         bplOe1VT0SkTENU2tvWzX6G5w7a5RXqc91rDDC7N5CXqV3LJFBAKSOJOu/eQnw7lmk6L
         g9TTJRTik1ES0pbPq0JhN5HkhzAZz9cNHBKVdQfp14Qj4pgXL+xotjz2fHe7IJdBxiSr
         IFVA==
X-Gm-Message-State: APjAAAVQQ6/LEUoUuzV5RkVdRvv3XjXBWk/NpP51n+sVTsZ8kJARcJRw
        EMHX0Na3N2HPCUDunxtO5tkgPLuxEbY=
X-Google-Smtp-Source: APXvYqz8FaeT6349rpiq4FZHymuOujTmAJpMLxnxq0ksNLA1SLGwEbi0NRsc5W7LvzyKlPySiNYb1g==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr41780748pjw.43.1578298614934;
        Mon, 06 Jan 2020 00:16:54 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id b98sm23560362pjc.16.2020.01.06.00.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 00:16:54 -0800 (PST)
Date:   Mon, 6 Jan 2020 16:16:49 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] btrfs/140: use proper helpers to get devid and physical
 offset for corruption
Message-ID: <20200106081647.GE893866@desktop>
References: <20200103111810.658-1-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103111810.658-1-jth@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 03, 2020 at 12:18:10PM +0100, Johannes Thumshirn wrote:
> Similar to fstests commit 1a27bf14ef8b "btrfs/14[23]: Use proper help to
> get both devid and physical offset for corruption." btrfs/140 needs the
> same treatment to pass with updated btrfs-progs.
> 
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>
> ---

Qu Wenruo has posted "fstests: btrfs/14[01]: Use proper helper to get
both devid and physical for corruption" earlier, and I'll apply his
patch instead.

Thanks,
Eryu
