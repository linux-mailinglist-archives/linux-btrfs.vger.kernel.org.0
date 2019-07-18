Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C986D30C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2019 19:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfGRRsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jul 2019 13:48:16 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33073 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRRsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jul 2019 13:48:15 -0400
Received: by mail-lf1-f45.google.com with SMTP id x3so19914612lfc.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2019 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h6oc3pUmKWj8hRkCBOhk4SaVozjiyV9rvniLnXPuv4A=;
        b=IJHtc5qGulhOfomUSTn476ysra2AY9ZSjhIBRIzLmyXUrDeYy8WzTZowuCumzygELY
         zmmV51wU9cst794Q3kwj+fha9Iovck0Gdb7nHHWsntiDKNcdE5S8252g5pKkNME2Qn5+
         4rdXoBjcMqigXjSmIPdIgCffhyhnpIijj6j/d0pJLYlXcu6fI1EB/jPo4hcqetwFsiSw
         1hScZfgUrT6d5P0mhSPl5ZpWwcISGRW/L8cSm4pbxq06k4R3Wqm7i6MdY2j4FRyMu6KO
         3MGEyeuk23RU2Z9PWzB48tKnsL+YpG4qzfr7VRpH2LCUlbz2qaF1Y+eoNOOI9cZAJC2l
         j85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=h6oc3pUmKWj8hRkCBOhk4SaVozjiyV9rvniLnXPuv4A=;
        b=omMawQK/2a14lmvj0rt6Lz7nYcbs/Y79DbfBTIgYX37uk3KiXBfcFugLET1u2bSOM/
         ziK3D7ieQzcjPCYyndGMtUDOC5vmoQ4Tz6fEUfpt/e+xaIdUG1YkFPPLzIFhkEvyw+Ba
         re7dNlm4R1NcQfeE95+TD5Klr0GZuAgHYzSr1S8vpYO5RVPtuj4qGaRvI1fuFNkm3+J0
         LQwBKVzFbPpOiBKJrEmKhgyYNIzARm2xrp4isN/TF3QtZ/om2K/DfI1x9MEk6bZ6z3yt
         aUAmpDd86GgmqIryNicpiQoqwHufmHDbKF4DD2/xGBDaC/eP8Ua5E2n2/RLc9jUZQupy
         3P1g==
X-Gm-Message-State: APjAAAVd2Sg6S9egg7wBNWWz/bS077gL2qNHNkO6fqQIpviJi1qlICTV
        t4SU6MEkYE3mmqAzFfKHcOa9f+Jl+ls=
X-Google-Smtp-Source: APXvYqzffbJpBbxuNwG9lwpGWymz5WF/cQgQeD5hVTRfJKM0RSTeKs0NLXjaF2gxhhXuq+cwOGB+kg==
X-Received: by 2002:a19:f819:: with SMTP id a25mr22668030lff.183.1563472093115;
        Thu, 18 Jul 2019 10:48:13 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-203.nat.spd-mgts.ru. [109.252.55.203])
        by smtp.gmail.com with ESMTPSA id t67sm5242971lje.19.2019.07.18.10.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 10:48:11 -0700 (PDT)
Subject: Re: find subvolume directories
To:     Axel Burri <axel@tty0.ch>, linux-btrfs@vger.kernel.org
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
 <04d6d375-ee33-8d77-d139-a81302efd7f8@tty0.ch>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <abb990f6-91b2-0762-e7d2-478d2cf90f42@gmail.com>
Date:   Thu, 18 Jul 2019 20:48:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <04d6d375-ee33-8d77-d139-a81302efd7f8@tty0.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

18.07.2019 15:00, Axel Burri пишет:
> On 13/07/2019 01.17, Ulli Horlacher wrote:
>> I need to find (all) subvolume directories.
>> I know, btrfs subvolumes root directories have inode #256, but a
>> "find / -inum 256" is horrible slow!
> 
> Having all required frameworks for this in btrbk, implementing a "list
> all subvolumes below <path>" command was quite easy to implement:
> 
> https://github.com/digint/btrbk/commit/e12d980502
> 
>  - get mounted filesystems from /proc/self/mountinfo
>  - fetch subvolumes using "btrfs subvolume list" (fast, needs root)
>  - filter and print subvolumes below mount point
> 
> Note that this approach needs root, as "btrfs subvolume list" requires
> "cap_sys_admin" and "cap_dac_read_search".
> 
> 
> Try it:
> 
> Download btrbk from "action-ls" feature branch (no dependencies needed):
> 
> # cd /tmp
> # wget https://raw.githubusercontent.com/digint/btrbk/action-ls/btrbk
> # chmod +x /tmp/btrbk
> 
> 
> List subvolumes below /home:
> 
> # ./btrbk ls /home
> # ./btrbk ls /home -t
> 
> 
> Comprehensive list of all accessible subvolumes:
> 
> # ./btrbk ls / --format=long
> 

Seems to work, also across non-btrfs mount point. One thing missing is
actual subvolume path (not current mount point).

> 
> Show commands run by btrbk:
> 
> # ./btrbk ls / -l debug
> 
> 
> If you need to run this as a regular user (and if you are brave), you
> can install setcap enabled btrfs binaries from:
> https://github.com/digint/btrfs-progs-btrbk
> 
> Hope this helps,
> 
> - Axel
> 

