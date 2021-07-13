Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB093C7533
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 18:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhGMQse (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 12:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhGMQsd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 12:48:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAC5C0613DD
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 09:45:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p14-20020a17090ad30eb02901731c776526so1792539pju.4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=u0k5PIIamyF7vnNDnfaopJCJ8ScH1EdrVBHCzxPGOUs=;
        b=gVU4pVwfGVP1skx9IvhDWGbj4ZdatthDVlXfkpNblEHQAJkOtConNee4n6XrWNqTNH
         v8aGN9whscYRM9k0NneeUkBNfWgmho9WW5Uq4v3/dp4eRSEXKm5vpANufl+2ZzVDN0CZ
         7CUwoYHSWBiAyp8YHUufY5+KHQz8fkSqZ7q3iMmCS8474Lp/62A0WGns9yktI4sJ+TzH
         Rg7ghUbICzuWv/9A9IyQXXNYATn112KNJmjvYZnn+eNLv+kuLfu4DA6kyx/K0MmKcJeV
         H0jmAEi0cV/Y0mwZfG1OWHOCCM6IrydudU7MZfxlak95dUq1J2CH2A69PvoQeMiM0fLT
         kGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u0k5PIIamyF7vnNDnfaopJCJ8ScH1EdrVBHCzxPGOUs=;
        b=KHykVL9jysynELpNRBMgill2KjzbB6YrWVFkQ1nMxSqLQgG1e0ra6zL/XCUAKyu/Xl
         l+RWqtNzdp54Fi8ssM/O5TxO8BrQIRkZ1dv8qz1WpgAaf+LyT0b4l5XA503CXSnRFlEh
         ehw8Nc2QJaoTO2hTt+9TUMDMElGxk/iftjUp+5Bw2cs/LSS5LFpz6PjvS7YUayXcSja5
         z0j8ze2xdEQBM67UKHYWabeJiQjpVYynMHS+nfJB4kE+sDviL7RK3DY/Q9hvr5pCacM8
         Su70y0peUDJVNlzQmZsET8oTJUtzQ4gJQY7KL9qBqqOotjwO0dXiZMsUnCsmlxx7IGQN
         0xUA==
X-Gm-Message-State: AOAM532IdZPFtXBBhaFT5wVGUuQmU1jGS+VCKPxNNQI29OHCQPSt8Tt/
        6EAsQfPsNWJiELBgEQ8AhBTnicyI+tZmJw==
X-Google-Smtp-Source: ABdhPJy3qsAlV9hnIl3yihdJ3Sq0q5y4I1kWUMp3Y8MK3hv+/ELQuAt24g5cOgvkfCjWLWqs3/jP7g==
X-Received: by 2002:a17:902:ec86:b029:12a:e689:88e5 with SMTP id x6-20020a170902ec86b029012ae68988e5mr4226418plg.14.1626194742278;
        Tue, 13 Jul 2021 09:45:42 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id js5sm17574128pjb.40.2021.07.13.09.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 09:45:41 -0700 (PDT)
Date:   Tue, 13 Jul 2021 16:45:32 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Message-ID: <20210713164532.GA71156@realwakka>
References: <20210711161007.68589-1-realwakka@gmail.com>
 <20d7b0a8-8e1c-c13a-6a94-525a110a6b0e@suse.com>
 <20210712064008.GB68357@realwakka>
 <933cc012-1b8e-3d5c-d8ed-76e81f461d34@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <933cc012-1b8e-3d5c-d8ed-76e81f461d34@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 12, 2021 at 02:46:39PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/12 下午2:40, Sidong Yang wrote:
> [...]
> > > > +	sk->max_offset = UINT64_MAX;
> > > > +	sk->min_transid = 0;
> > > > +	sk->max_transid = UINT64_MAX;
> > > > +	sk->min_type = sk->max_type = BTRFS_EXTENT_DATA_KEY;
> > > > +	sk->nr_items = 4096;
> > > 
> > > You may want to do the tree search ioctl in a loop, as it's pretty common
> > > for super large or heavily fragmented inode to have way more items than one
> > > ioctl can return.
> > 
> > I don't think much about this. I wonder if it's proper way to search
> > tree. is there any better way than this code?
> 
> Here is one example:
> 
> https://github.com/kilobyte/compsize/blob/master/compsize.c#L179
> 
> It goes @again label to restart from last offset + 1.

Thanks, I read the code you provided. It seems that compsize is also
doing to what this patch do. 

The 'do_file' function checks if nr_items is larger than 512. I wonder
that the number '512' is such an magic number. I'll check it by my own
effort. 

Thanks,
Sidong

> 
> Thanks,
> Qu
> 
