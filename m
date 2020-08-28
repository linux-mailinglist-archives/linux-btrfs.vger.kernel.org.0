Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7262553F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 07:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgH1FJb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 01:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgH1FJa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 01:09:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B55C061264
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Aug 2020 22:09:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r13so5580782ljm.0
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Aug 2020 22:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+iQo0UHOX3WhhKnvDPF2NRL5hLroOcyEzqaDY1BkcNI=;
        b=ty2bBUPofRdMRtm6Ojkkt+z1OLpOt7C39iwmnc3L2ljuiRZCR4TOPaFgetQ+Qs2otT
         oL4EypXA7uJjVFb8CWY2QK6i5vau2gUK3wEmhhX3VaitRUL1UOVduZoI4TVpZbEZu/Df
         Ppk35qA2hQYeJqhsltnKB+jaqxpG765U/I23zed2Nr4+OE9jaN0XUjBNFVQUl6BklCWC
         YhtTaxWVLLnvH8U/QbqEl8vRqbSyZr2ElOZwL4FKNOIKCle6W45q3vlW3iqyuBFY2Eef
         Gaa8mTWgp9Hezs4Xi8RtrDCNfhliwqdVL0itMXjSwqmCatPBI5UcStRH8XQ7hHZiKc2U
         IFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+iQo0UHOX3WhhKnvDPF2NRL5hLroOcyEzqaDY1BkcNI=;
        b=j3ocCRIR4epe66w3CwBnF0InVntUNM0UlfKatRUYEuh+3DGeeN2H8tKSjNnOjbdf2B
         y/l3IUZSBhXuI7Ea0E0bGraUqHyAjZ64rwSdpREsaPpv8QvHtaTA0JHDVvOsi5vFE73V
         Pu5jqFw27fIGhp2aF3lU+8NgVkK1Yj+2ndCnorGY1r7zYp189yGGsVpdLisbTtYPZOlp
         rSlL6y/aYOjb653CygkuP6807U+qO0tXyAxIZgfGkabs104h1ubgtqrfUV4DTVBwbcvw
         a25VQZZREaV/kJlHcPywDjsm2lJkm4P2RL9Fd5jnHlxjNz7Pz2K/FuZH+xPHcTmGYhK0
         ogxQ==
X-Gm-Message-State: AOAM531RnIsVeqRPSnFjEfM+Nd93u/FfWQ/GfQvhdGref5qum4YaQJEg
        LjcH5i4zAF64yXC4uRk7aI+xpLhZu/A=
X-Google-Smtp-Source: ABdhPJzE5Y4IaJrGdqqCzchA6drufeueJre2hu/9ztlIISAxeIJU2u2rJSZMxtUxOXKOqo9HAaRqXQ==
X-Received: by 2002:a2e:a58d:: with SMTP id m13mr50031ljp.84.1598591368013;
        Thu, 27 Aug 2020 22:09:28 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:93a3:28ae:5b31:d89a:107? ([2a00:1370:812d:93a3:28ae:5b31:d89a:107])
        by smtp.gmail.com with ESMTPSA id w19sm902736ljd.112.2020.08.27.22.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 22:09:27 -0700 (PDT)
Subject: Re: adding new devices to degraded raid1
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Eric Wong <e@80x24.org>
Cc:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
References: <20200827124147.GA16923@dcvr>
 <862ab235-298a-12eb-647b-04ec01d95293@libero.it>
 <20200828003037.GU5890@hungrycats.org> <20200828023412.GA308@dcvr>
 <20200828043627.GE8346@hungrycats.org>
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
Message-ID: <0efae4eb-30dd-4d5a-d5fa-eac7ffc1fad8@gmail.com>
Date:   Fri, 28 Aug 2020 08:09:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828043627.GE8346@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

28.08.2020 07:36, Zygo Blaxell пишет:
> 
> Replace just computes the contents of the filesystem the same way scrub
> does:  except for the occasional metadata seek, it runs at wire speeds
> because it reads blocks in order from one disk and writes in order on
> the other disk, 99.999% of the time.
> 

Does it write them to the same absolute disk locations? IOW - is it
possible to use smaller disk for replace or it must be at least as large
as original disk?
