Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3434222D55F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jul 2020 08:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGYGLD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jul 2020 02:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYGLD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jul 2020 02:11:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078AAC0619D3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 23:11:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 140so6328754lfi.5
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 23:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AvfTRctuPEW4BD1w35mf5PaNxK8HZTzrd8xhDrnH6zA=;
        b=i012Xe4IWF3CeDCeqJYdBEfyM9SYqedGI0CHCdNSou6MvJwZZ2RyVfVXUe8EMJc5It
         DmWZcAHMfVCZA7KPhnpb+hmJ3ScjoT/LN5UfbckEr18PgEE40DRbPhjan68y8XoCxEju
         xDdVmWy104bDwPE3n9i9WoKdGgUL3CIPfxYdiNGUKn3Ale1BghxHgdFoinacbHgtqvQp
         BjkuZqZu4Qw+whndf6EfhtAGYyzXx7lueeg0on66SMoIdCeJQSXap0K4DLaDkrMReYM1
         CvrTm9Mi3BF+6ldoVWxaTLWx97mAtU8v/y+sA3z5yzut4X0hP+2IhWBp+zuNvavqLI74
         KHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AvfTRctuPEW4BD1w35mf5PaNxK8HZTzrd8xhDrnH6zA=;
        b=HkGBle9i7aIMxoFoyMkwo3GuZWnv3Ia+KiSuUgwsw38VgtZmYTBGXt7BnihYA9fUn7
         ajBiVZxQ2b5C2YxhokGDtMYpi56dBcMRjZOBRqBmv5YJWfxoLuudsHoB4h3MYQVz2cc8
         QIi/qXqbyzp99bsVo4URjeEPu8iMoNY9+87QdhEPzYheCJPmtOTB1gpslC/LI9YjI5Vi
         AGfhrnOyKVGf0jDTraW4PFASIIeTiZlMDnCsv0NR7fR2oFMPldsaLpAUlf/vqZD5tMcQ
         uiLi9wsD8szu1rkBBSbPnzJGu1Oh+c70iJ6qDd8iaWkfcLGYUAAfXaR//fs7NhNoXNgY
         ecjQ==
X-Gm-Message-State: AOAM533FwBdTepJMVct0xU25cqTBHeQbU2PIiLqIEGEXtmI44ujlq0oY
        XpWzrb4d7mbPllxFUukbAEk3Z19g
X-Google-Smtp-Source: ABdhPJyaObHiX/qROxtTO5mqVZykODtNkJj6D5DqPrhwpk8TsLLjJPspgsBc4r6KF0Id7iNhyIeGRw==
X-Received: by 2002:a05:6512:2010:: with SMTP id a16mr6610064lfb.196.1595657459879;
        Fri, 24 Jul 2020 23:10:59 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:c763:71ff:8633:9e4a:bf5b? ([2a00:1370:812d:c763:71ff:8633:9e4a:bf5b])
        by smtp.gmail.com with ESMTPSA id c4sm1090062lfs.27.2020.07.24.23.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 23:10:59 -0700 (PDT)
Subject: Re: mixing raid1 and raid0?
To:     Eric Wong <e@80x24.org>, linux-btrfs@vger.kernel.org
References: <20200725055728.GA6238@dcvr>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUdpQkR4aVJ3d1JCQUMz
 Q045d2R3cFZFcVVHbVNvcUY4dFdWSVQ0UC9iTENTWkxraW5TWjJkcnNibEtwZEc3CngrZ3V4
 d3RzK0xnSThxamYvcTVMYWgxVHdPcXpEdmpIWUoxd2JCYXV4WjAzbkR6U0xVaEQ0TXMxSXNx
 bEl3eVQKTHVtUXM0dmNRZHZMeGpGc0c3MGFEZ2xnVVNCb2d0YUlFc2lZWlhsNFgwajNMOWZW
 c3R1ejQvd1h0d0NnMWNOLwp5di9lQkMwdGtjTTFuc0pYUXJDNUF5OEQvMWFBNXFQdGljTEJw
 bUVCeHFrZjBFTUh1enlyRmxxVncxdFVqWitFCnAyTE1sZW04bWFsUHZmZFpLRVo3MVcxYS9Y
 YlJuOEZFU09wMHRVYTVHd2RvRFhnRXAxQ0pVbitXTHVyUjBLUEQKZjAxRTRqL1BISEFvQUJn
 cnFjT1RjSVZvTnB2MmdOaUJ5U1ZzTkd6RlhUZVkvWWQ2dlFjbGtxakJZT05HTjNyOQpSOGJX
 QS8wWTFqNFhLNjFxam93UmszSXk4c0JnZ00zUG1tTlJVSllncm9lcnBjQXIyYnl6NndUc2Iz
 VTdPelVaCjFMbGdpc2s1UXVtMFJONzdtM0kzN0ZYbEloQ21TRVk3S1pWekdOVzNibHVnTEhj
 ZncvSHVDQjdSMXc1cWlMV0sKSzZlQ1FITCtCWndpVThoWDNkdFRxOWQ3V2hSVzVuc1ZQRWFQ
 cXVkUWZNU2kvVXgxa2JRbVFXNWtjbVY1SUVKdgpjbnBsYm10dmRpQThZWEoyYVdScVlXRnlR
 R2R0WVdsc0xtTnZiVDZJWUFRVEVRSUFJQVVDU1hzNk5RSWJBd1lMCkNRZ0hBd0lFRlFJSUF3
 UVdBZ01CQWg0QkFoZUFBQW9KRUVlaXpMcmFYZmVNTE9ZQW5qNG92cGthK21YTnpJbWUKWUNk
 NUxxVzV0bzhGQUo0dlA0SVcrSWM3ZVlYeENMTTcvem05WU1VVmJyUW5RVzVrY21WNUlFSnZj
 bnBsYm10dgpkaUE4WVhKMmFXUnFZV0Z5UUc1bGQyMWhhV3d1Y25VK2lGNEVFeEVDQUI0RkFr
 SXR5WkFDR3dNR0N3a0lCd01DCkF4VUNBd01XQWdFQ0hnRUNGNEFBQ2drUVI2TE11dHBkOTR4
 ajhnQ2VJbThlK2U0cXhETWpRRXhGYlVMNXdNaWkKWUQwQW9LbUlCUzVIRW9wL1R5UUpkTmc2
 U3Z6VmlQRGR0Q1JCYm1SeVpYa2dRbTl5ZW1WdWEyOTJJRHhoY25acApaR3BoWVhKQWJXRnBi
 QzV5ZFQ2SVhBUVRFUUlBSEFVQ1Bxems4QUliQXdRTEJ3TUNBeFVDQXdNV0FnRUNIZ0VDCkY0
 QUFDZ2tRUjZMTXV0cGQ5NHlEdFFDZ2k5NHJoQXdTMXFqK2ZhampiRE02QmlTN0Irc0FvSi9S
 RG1hN0tyQTEKbkllc2JuS29MY1FMYkpZbHRDUkJibVJ5WldvZ1FtOXljMlZ1YTI5M0lEeGhj
 blpwWkdwaFlYSkFiV0ZwYkM1eQpkVDZJVndRVEVRSUFGd1VDUEdKSERRVUxCd29EQkFNVkF3
 SURGZ0lCQWhlQUFBb0pFRWVpekxyYVhmZU1pcFlBCm9MblllRUJmOGNvV2lud3hUZThEVjBS
 T2J4N1NBS0RFamwzdFFxZEY3MGFQd0lPMmgvM0ZqczJjZnJRbVFXNWsKY21WcElFSnZjbnBs
 Ym10dmRpQThZWEoyYVdScVlXRnlRR2R0WVdsc0xtTnZiVDZJWlFRVEVRSUFKUUliQXdZTApD
 UWdIQXdJR0ZRZ0NDUW9MQkJZQ0F3RUNIZ0VDRjRBRkFsaVdBaVFDR1FFQUNna1FSNkxNdXRw
 ZDk0d0ZHd0NlCk51UW5NRHh2ZS9GbzNFdllJa0FPbit6RTIxY0FuUkNRVFhkMWhUZ2NSSGZw
 QXJFZC9SY2I1K1NjdVFFTkJEeGkKUnlRUUJBQ1F0TUUzM1VIZkZPQ0FwTGtpNGtMRnJJdzE1
 QTVhc3VhMTBqbTVJdCtoeHpJOWpEUjkvYk5FS0RUSwpTY2lIbk03YVJVZ2dMd1R0KzZDWGtN
 eThhbit0VnFHTC9NdkRjNC9SS0tsWnhqMzl4UDd3VlhkdDh5MWNpWTRaCnFxWmYzdG1tU045
 RGxMY1pKSU9UODJEYUpadXZyN1VKN3JMekJGYkFVaDR5UkthTm53QURCd1FBak52TXIvS0IK
 Y0dzVi9VdnhaU20vbWRwdlVQdGN3OXFtYnhDcnFGUW9CNlRtb1o3RjZ3cC9yTDNUa1E1VUVs
 UFJnc0cxMitEawo5R2dSaG5ueFRIQ0ZnTjFxVGlaTlg0WUlGcE5yZDBhdTNXL1hrbzc5TDBj
 NC80OXRlbjVPckZJL3BzeDUzZmhZCnZMWWZrSm5jNjJoOGhpTmVNNmtxWWEveDBCRWRkdTky
 Wkc2SVJnUVlFUUlBQmdVQ1BHSkhKQUFLQ1JCSG9zeTYKMmwzM2pNaGRBSjQ4UDdXRHZLTFFR
 NU1Lbm4yRC9USTMzN3VBL2dDZ241bW52bTRTQmN0YmhhU0JnY2tSbWdTeApmd1E9Cj1nWDEr
 Ci0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
Message-ID: <fca00204-0489-bb67-65ea-ca3d9e3d255e@gmail.com>
Date:   Sat, 25 Jul 2020 09:10:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200725055728.GA6238@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

25.07.2020 09:02, Eric Wong пишет:
> Hey all, I've started using btrfs recently with old HDDs of
> various sizes in a btrfs raid1 pool.  It seems pretty good from
> a flexibility and redundancy standpoint.
> 
> However, things like temporary files, caches, etc. don't need to
> be raid1, and raid0 might allow me to reduce wear on HDDs; so
> I'd like to make part of it raid0 while keeping most of it raid1.
> 
> If my btrfs is mounted as /mnt/btrfs, would the following do
> what I want?
> 
>   btrfs balance start -dconvert=raid1 -mconvert=raid1 /mnt/btrfs/precious
>   btrfs balance start -dconvert=raid0 -mconvert=raid0 /mnt/btrfs/junk
> 
> Or should I make a separate FS for temporary and disposable
> raid0 data?
> 
> Thanks
> 

Balance does not work on logical directory or subvolume level. Even if
it did, btrfs filesystem has only one target profile and it is the last
one used (i.e. the target profile of the last convert). So any new
writes after the last balance command would be using raid0 profile
everywhere.

Different allocation profiles for different subvolumes comes pretty
regular as wish list.

So you in your case you will need separate filesytem.
