Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972CC3074D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 12:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhA1Lb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 06:31:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45372 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhA1Lb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 06:31:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SBTtas079084;
        Thu, 28 Jan 2021 11:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=uGd+0Xb/YePYFlGoeYygjd5U5w/9yKRZJtjuoquYzXQ=;
 b=pt6bYTUwhb4d20SJeNW8th3dXpaf5KjmJLL45S/Yji5Pr8bOQhec6/+0haUUGDYr4dlU
 f/2n1YMsjmLt0ufft/qOvf+la/004+lo78Q+DR/u7aIdbW6+uBUMKy6Ijgvq8Krf7zdT
 baNzv6/l3ec2TYXVcjQGzFgeWAVlfNhj/Oio7suAnDJcOHql+V4FS8sXZA9RAad3LzoS
 L2GFro9N2EcBMx9KtDzqygjgvJkjHxqNS5B+nj3rVQBCB5PxvbSYas8zeicv57tmCduT
 Kj04vWqFZXZQfIjuKvyNxLA7dJ78jDV8+LhXSwwGsB4w0zwQVqsKJgVhaLuHLDg7GSHK yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 368b7r3pjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 11:30:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SBLBdc001613;
        Thu, 28 Jan 2021 11:30:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 368wcqjwdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 11:30:41 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10SBUdgg023435;
        Thu, 28 Jan 2021 11:30:39 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jan 2021 03:30:39 -0800
Date:   Thu, 28 Jan 2021 14:30:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add comment on why we can return 0 if we failed
 to atomically lock the page in read_extent_buffer_pages()
Message-ID: <20210128113032.GS20820@kadam>
References: <20210128112508.123614-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128112508.123614-1-wqu@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280057
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280058
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yeah.  Once you know it's only for readahead then that makes perfect
sense.  Thanks!

regards,
dan carpenter

