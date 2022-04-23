Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE7250C7BA
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 08:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiDWGHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Apr 2022 02:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiDWGHr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Apr 2022 02:07:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669451384BE
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 23:04:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w1so17704418lfa.4
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bO5koPoX7wsWLeMs6ro/fwJ89SK1VytEMyMAUR0z594=;
        b=Md7pVcHCyxS/CgtUp9XdAA5IWzyJYnorLemtfmydn675NfRJSRFTVSggu7r6tje7h4
         4rAPdoPN24RPKYHdVTNXnnylolM0c08bGvY43PszlzYgKlkqAq6aYBG+CQrf3hCHcN1X
         iRSruRDQicNsAV96O6u9kT6hblKRam0/+oh7tHvwgb2MNgJKmvrV2HAiA3ukosm90al8
         SGN/XOrGP99N1W0BMBXeXWMQ881QgZM7QfcW5+R8ey/8OYVDRRebFk1dbWPfq3iqUhD+
         rEyev25J8ELfk9yvZc77tOtGGMTpuOS0PUDSen7Fu/r1+VVqWTzqYRE1O6QJ8Kq+5o4j
         26zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bO5koPoX7wsWLeMs6ro/fwJ89SK1VytEMyMAUR0z594=;
        b=rBgox1bain6kzhFTkB805bH54c7x3hXvxjC0SjD0Lold0lRYRfDb2wysUMuqJWTKNN
         ozdSgTIOfuuagDaa5zI2BrdNlP4SQvH6qOV45jIjiSDnTwfSTQ9Ij3it043Vnrlx+A5C
         7BgTfH3pgv+Mo/ckUm+7MniE8AwFU0h174YD0gwzkl7Gif2WLsZqrryxkcielu4hmDMG
         lRwf/LnAsVpLb7v7VYXUopxJDF87NOdElhCkj2c3VSfP6QD1I66liRzguA3AtpoL9t3Z
         Tr1odKC1e3s8Q889qcKmHHP0W5sukUuZqpMk4aoeVbTyQZ2J711yK5sia4tK+qMWPNGO
         osaA==
X-Gm-Message-State: AOAM530IwGHzhZj9RCg8Jhw+Pmj7FjI5kS9mY4+/VuQUvlvVVmjo+4u7
        QMN5WRN5K2onKl8PgIOpVHxEmXUClziUXQ==
X-Google-Smtp-Source: ABdhPJxwo59F0jNo8NcxfNSd18O1fK3nKltwBmBHaxun9cYh4REOn+u3hxNCxdE+ZxuWeFBsWA320g==
X-Received: by 2002:a05:6512:32ca:b0:471:d0ba:4383 with SMTP id f10-20020a05651232ca00b00471d0ba4383mr5575591lfg.240.1650693888697;
        Fri, 22 Apr 2022 23:04:48 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:3365:df52:ce71:56d4:e7e6? ([2a00:1370:8182:3365:df52:ce71:56d4:e7e6])
        by smtp.gmail.com with ESMTPSA id r12-20020a2eb60c000000b0024efc1fb573sm260497ljn.56.2022.04.22.23.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 23:04:48 -0700 (PDT)
Message-ID: <7a9e7e85-e7d6-cd68-83e7-76ebc6cffee5@gmail.com>
Date:   Sat, 23 Apr 2022 09:04:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: space still allocated post deletion
Content-Language: en-US
To:     Alex Powell <alexj.powellalt@googlemail.com>,
        Graham Cobb <g.btrfs@cobb.me.uk>
Cc:     linux-btrfs@vger.kernel.org
References: <CAKGv6Cq+uwBMgo6th6E16=om8321wTO3fZPXF151VLSYiexFUg@mail.gmail.com>
 <6672365e-c3d2-1a4c-7eb6-957f7a692d3a@cobb.uk.net>
 <CAKGv6CovkUjb92MAaM-irNcJvJk2P_2QNpybzCSsSs2RMgfz4A@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAKGv6CovkUjb92MAaM-irNcJvJk2P_2QNpybzCSsSs2RMgfz4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20.04.2022 10:17, Alex Powell wrote:
> Thank you,
> The issue was veeam keeping snapshots in .veeam-snapshots above the
> root subvolume. I have no idea why this is the expected behaviour,
> because the backups are set to go to /mnt/data.
> 

Snapshots are the source of backup data. Veeam always creates snapshot
to get stable state, either using own driver or (on btrfs) using btrfs
native snapshots. Then Veeam reads data from those snapshots and stores
in location where you have specified it. See Veeam Agent for Linux
documentation (I assume this is what you are using).

> I'm confident that if I wait 7 days, the backup retention period, this
> will fix itself. So this itself is not a bug in btrfs, it is more a
> misconfiguration by Ubuntu or Veeam.
> 

I fail to see any misconfiguration. If you imply that btrfs snapshots
should be located on external disk - that is simply not possible.
