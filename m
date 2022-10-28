Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AB6610947
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 06:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJ1EaV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 00:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJ1EaU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 00:30:20 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02C65BCA8
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 21:30:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h12so126050ljg.9
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 21:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iodjg6OyL6j9TbySX03FfRCWeGghgvpsep/6PMuiLTE=;
        b=kHNBZHZAq5fmZOOd66HBx1Cf35j5DU7stYOayQ19gR9YO2cbQrECBBcK4RbOI45Wmq
         RaD4fkDdFRcwNAjS1Hcx6nc6a9uSqrOmrP083Bz3Gl7P+KhWOq8dAxRjp0Br1rPM/9TG
         ADwO2tEUwKoRYuhuCxi9yqCWxN3lP6ZfcZkagHJktqlAKpGHSIutjIJFugymD1tQpM0q
         HmnnUmnm51zg9xc0V3/I9I06A88BVP4/pJDoSgVeR2hCfUyB9T/eyUWanAH8k9ZNiTbb
         uL5/xqJlvRkwdmNCMpofEhDDkwS5749NXfmxYF5xG0fU3tdpSEEGl10VFllyzqlSIorJ
         nZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iodjg6OyL6j9TbySX03FfRCWeGghgvpsep/6PMuiLTE=;
        b=l5m3C3RsQ0qnrBUzNs3qG5z6BceO/D/aaqlCgLi0xEaS1bk/5Fdn/i1S09zllGmZH+
         k+sHS3gCR9ycR3oy67KmS2pZA91z9tNlihr53asM06phbCsYwd6ks+9iuH9uRAsao/TH
         ZYFtJBgWHeezV0YFk6sbVzPew38fEu17DtDwRR6zL1A6bZBUIyLJFF8OthlnoxRVhzRJ
         zZhlos/IKjHQ2JrhlbnnbXpLK5zF0HHq9HVIEZvOHVexrZ2g6r4zth2e3ykwaKnCYVXX
         NZvNQZ7BDYUIb9pnnhc8r7VO4F9q3N9SYTQS1e63Fb0xDifCBgOtynUcgSQ1PMY3YWhC
         As6Q==
X-Gm-Message-State: ACrzQf20vsS+TiMNQK4Hd4JedxHpfJSM4lnIF7QI8BhSaAKzZfvzACEY
        FPVLqirTfmdgMfou5p9yuEskCmbBsnM=
X-Google-Smtp-Source: AMsMyM4/9uxKvKVksiAX3fypC6D7vT8O/dj9trTmlShwXBYuYrJQXTmchanc1R6/ZRU+iuhH8cmSOQ==
X-Received: by 2002:a2e:7c07:0:b0:276:a677:b7d7 with SMTP id x7-20020a2e7c07000000b00276a677b7d7mr12850559ljc.383.1666931417948;
        Thu, 27 Oct 2022 21:30:17 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:683d:9107:f4a1:5e1e:870f? ([2a00:1370:8182:683d:9107:f4a1:5e1e:870f])
        by smtp.gmail.com with ESMTPSA id bj11-20020a2eaa8b000000b0026fb1c3e6ddsm468077ljb.62.2022.10.27.21.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 21:30:17 -0700 (PDT)
Message-ID: <a6b9bbb8-6f1b-f56b-72db-e366fcd06247@gmail.com>
Date:   Fri, 28 Oct 2022 07:30:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Major bug in BTRFS (syncs are ignored with libaio or io_uring)
Content-Language: en-US
To:     =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= 
        <socketpair@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAEmTpZGRKbzc16fWPvxbr6AfFsQoLmz-Lcg-7OgJOZDboJ+SGQ@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAEmTpZGRKbzc16fWPvxbr6AfFsQoLmz-Lcg-7OgJOZDboJ+SGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28.10.2022 00:21, Марк Коренберг wrote:
> How to reproduce (I tested in kernel 6.1):
> 
> 2.  mkfs.btrfs over a partition.
> 3.  mount -o lazytime,noatime
> 4.  touch file.dat
> 5.  chattr +C file.dat # turns off compression, checksumming and COW
> 6.  fallocate -l1G file.dat
> 7.  # prefill the file with random data
>      fio -ioengine=psync                      -name=test -bs=1M
> -rw=write                 -filename=file.dat
> 8.  fio -ioengine=psync    -sync=1 -direct=1 -name=test -bs=4k
> -rw=randwrite -runtime=60 -filename=file.dat  # Will show, say, 2K
> IOPs
> 9.  fio -ioengine=io_uring -sync=1 -direct=1 -name=test -bs=4k
> -rw=randwrite -runtime=60 -filename=file.dat  # Will show, say, 32K
> IOPs
> 10. fio -ioengine=libaio   -sync=1 -direct=1 -name=test -bs=4k
> -rw=randwrite -runtime=60 -filename=file.dat  # Will show, say, 32K
> IOPs
> 
> Steps 9 and 10 show implausible IOPs.
> 
> This does not happen on, say, Ext4 (all the methods give roughly the same IOPs).
> 
> Removing -sync=1 on all engines on Ext4 gives immediate return (as
> expected because everything gets merged and finally written very fast)
> 
> Adding/Removing -sync=1 with io_uring or libaio changes nothing on
> BTRFS (it's definitely a bug)
> 
> 
> I consider it's a bug in BTRFS. Very important bug because BTRFS
> becomes default FS in Fedora server/desktop now. This bug may cause
> data loss. That's why I set this bug as high priority.
> 
> 

Could you explain how this can cause data loss?
